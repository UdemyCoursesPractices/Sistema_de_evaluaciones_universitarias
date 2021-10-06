//SPDX-License_Identifier: MIT
pragma solidity >= 0.4.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract notas {
    //Direccion del profesor.
    address public profesor;
    //mapping para relaionar el hash de la identidad del alumno con su nota del examen.
    mapping(bytes32 => uint) Notas;

    //Array de  los alumnos que pidan revision de examen
    string[] revisiones;

    //EVENTOS _________________________________________
    event alumno_evaluado(bytes32);
    event evento_revision(string);

    //Contrstuctor
    constructor() public{
        profesor = msg.sender;
    }

    //cada ves que pasemos strings por parametros, debemos agregar el memory
    //funcion para evaluar alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public Unicamente(msg.sender){
        // Hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(_idAlumno);
        // Relacion entre el hash de la identificacion del alumno y su nota.
        Notas[hash_idAlumno] = _nota;
        //emision del evento
        emit alumno_evaluando

    }

}