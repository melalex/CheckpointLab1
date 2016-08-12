<?php
/**
 * Created by PhpStorm.
 * User: Александр Сергеевич
 * Date: 06.08.2016
 * Time: 16:15
 */


use Phalcon\Loader;
use Phalcon\Mvc\Micro;
use Phalcon\Di\FactoryDefault;
use Phalcon\Db\Adapter\Pdo\Mysql as PdoMysql;
use Phalcon\Http\Response;

$loader = new Loader();

$loader->registerDirs
(
    array
    (
        __DIR__ . '/models/'
    )
)->register();

$di = new FactoryDefault();

$di->set('db', function ()
{
    return new PdoMysql
    (
        array
        (
            "host"     => "localhost",
            "username" => "root",
            "password" => "pass",
            "dbname"   => "FamilyTree"
        )
    );
});

$app = new Micro($di);

$app->get('/api/trees', function () use ($app)
{
    $phql = "SELECT * FROM Trees ORDER BY title";
    $trees = $app->modelsManager->executeQuery($phql);

    $data = array();
    foreach ($trees as $tree)
    {

        $phql = "SELECT COUNT(*) FROM Persons WHERE identifier = :identifier:";
        $numberOfPersons = $app->modelsManager->executeQuery
        (
            $phql,
            array
            (
                'identifier' => $tree->identifier
            )
        );

        $data[] = array
        (
            'identifier' => $tree->identifier,
            'title'      => $tree->title,
            'author'     => $tree->author,
            'numberOfPersons' => $numberOfPersons
        );
    }

    echo json_encode($data);
});

$app->get('/api/trees/persons/{identifier}', function ($identifier) use($app)
{
    $phql = "SELECT * FROM Persons WHERE treeIdentifier LIKE :identifier:";
    $persons = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $identifier
        )
    );

    $data = array();
    foreach ($persons as $person)
    {
        $data[] = array
        (
            'identifier' => $person->identifier,
            'gender'     => $person->gender,
            'name'       => $person->name,
            'middleName' => $person->middleName,
            'surname'    => $person->surname,
            'father'     => $person->father,
            'mother'     => $person->mother
        );
    }

    echo json_encode($data);
});

$app->get('/api/persons/{identifier}', function ($identifier) use ($app)
{
    $phql = "SELECT * FROM Persons WHERE identifier = :identifier:";
    $person = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $identifier
        )
    )->getFirst();

    $response = new Response();

    if ($person == false)
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'NOT-FOUND'
            )
        );
    }
    else
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'FOUND',
                'data'   => array
                (
                    'identifier' => $person->identifier,
                    'gender'     => $person->gender,
                    'name'       => $person->name,
                    'middleName' => $person->middleName,
                    'surname'    => $person->surname,
                    'father'     => $person->father,
                    'mother'     => $person->mother
                )
            )
        );
    }

    return $response;
});

$app->post('/api/trees', function () use($app)
{
    $tree = $app->request->getJsonRawBody();

    $phql = "INSERT INTO Trees (identifier, title, author) VALUES (:identifier:, :title:, :author:)";

    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $tree->identifier,
            'title' => $tree->title,
            'author' => $tree->author,
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setStatusCode(201, "Created");

        $tree->id = $status->getModel()->id;

        $response->setJsonContent
        (
            array
            (
                'status' => 'OK',
            )
        );

    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent
        (
            array
            (
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->post('/api/persons', function () use($app)
{
    $person = $app->request->getJsonRawBody();

    $phql = "INSERT INTO Persons (identifier, gender, name, middleName, surname, mother, father, treeIdentifier) VALUES (:identifier:, :gender:, :name:, :middleName:, :surname:, :mother:, :father:, :treeIdentifier:)";

    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier'     => $person->identifier,
            'gender'         => $person->gender,
            'name'           => $person->name,
            'middleName'     => $person->middleName,
            'surname'        => $person->surname,
            'father'         => $person->father,
            'mother'         => $person->mother,
            'treeIdentifier' => $person->treeIdentifier,
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setStatusCode(201, "Created");

        $person->id = $status->getModel()->id;

        $response->setJsonContent
        (
            array
            (
                'status' => 'OK',
            )
        );

    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent
        (
            array
            (
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->put('/api/trees/{identifier}', function ($identifier) use($app)
{

    $tree = $app->request->getJsonRawBody();

    $phql = "UPDATE Trees SET title = :title:, author = :author: WHERE identifier = :identifier:";
    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $identifier,
            'title' => $tree->title,
            'author' => $tree->author,
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'OK',
                'data'   => $tree
            )
        );
    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent
        (
            array
            (
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->put('/api/persons/{identifier}', function ($identifier) use($app)
{

    $person = $app->request->getJsonRawBody();

    $phql = "UPDATE Persons SET gender = :gender:, name = :name:, middleName = :middleName:, surname = :surname:, father = :father:, mother = :mother: WHERE identifier = :identifier:";
    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier'     => $person->identifier,
            'gender'         => $person->gender,
            'name'           => $person->name,
            'middleName'     => $person->middleName,
            'surname'        => $person->surname,
            'father'         => $person->father,
            'mother'         => $person->mother,
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'OK',
                'data'   => $person
            )
        );
    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent
        (
            array
            (
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->delete('/api/trees/{identifier}', function ($identifier) use($app)
{
    $phql = "DELETE FROM Trees WHERE identifier = :identifier:";
    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $identifier
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'OK'
            )
        );
    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent(
            array(
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->delete('/api/persons/{identifier}', function ($identifier) use($app)
{
    $phql = "DELETE FROM Persons WHERE identifier = :identifier:";
    $status = $app->modelsManager->executeQuery
    (
        $phql,
        array
        (
            'identifier' => $identifier
        )
    );

    $response = new Response();

    if ($status->success() == true)
    {
        $response->setJsonContent
        (
            array
            (
                'status' => 'OK'
            )
        );
    }
    else
    {
        $response->setStatusCode(409, "Conflict");

        $errors = array();
        foreach ($status->getMessages() as $message)
        {
            $errors[] = $message->getMessage();
        }

        $response->setJsonContent(
            array(
                'status'   => 'ERROR',
                'messages' => $errors
            )
        );
    }

    return $response;
});

$app->notFound(function () use ($app)
{
    $app->response->setStatusCode(404, "Not Found")->sendHeaders();
    echo 'This is crazy, but this page was not found!';
});

$app->handle();