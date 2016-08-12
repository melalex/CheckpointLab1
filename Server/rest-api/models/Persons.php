<?php

/**
 * Created by PhpStorm.
 * User: melalex
 * Date: 8/8/16
 * Time: 22:24
 */

use Phalcon\Mvc\Model;

class Persons extends Model
{
    public $identifier;
    public $gender;
    public $name;
    public $middleName;
    public $surname;
    public $father;
    public $mother;
    public $treeIdentifier;
}