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
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        // Relacion entre el hash de la identificacion del alumno y su nota.
        Notas[hash_idAlumno] = _nota;
        //emision del evento
        emit alumno_evaluado(hash_idAlumno);
    }

    modifier Unicamente (address _direccion){
        //requiere que la direccion de parametro sea igual al owner
        require(_direccion == profesor, "No tiene permisos para ejecutar esta funcion");
        //Recordar el _; en los modifier.
        _;
    }

    //Funcion para ver als notas de un alumno
    function VerNotas(string memory _idAlumno) public view returns(uint){
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        return Notas[hash_idAlumno];
    }

    //Funcion para pedir revision del examen
    function Revision(string memory _idAlumno) public{
        // Almacenamiento de la identidad del alumno en un array.
        revisiones.push(_idAlumno);
        //Emision del evento
        emit evento_revision(_idAlumno);
    }

    //Ver Revisiones solicitadas. 
    function VerRevisiones()public view Unicamente(msg.sender) returns(string [] memory){
        return revisiones;
    }
}