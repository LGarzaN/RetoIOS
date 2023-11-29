import React, { useState, useEffect } from 'react';
import * as XLSX from 'xlsx';
import Button from 'react-bootstrap/Button';
import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';

function OptionPicker() {
  // Estado para almacenar las opciones de pacientes
  const [patientOptions, setPatientOptions] = useState([]);

  // Estado para rastrear el índice del paciente seleccionado
  const [selectedPatientIndex, setSelectedPatientIndex] = useState(0);

  // Estado para almacenar los registros de síntomas del paciente seleccionado
  const [symptomRecords, setSymptomRecords] = useState([]);

  // Efecto para obtener la lista de pacientes al cargar el componente
  useEffect(() => {
    fetch('http://10.22.129.138:5001/usuarios',)
      .then(response => response.json())
      .then(data => {
        // Mapear los datos de pacientes a un formato que incluya un índice, un valor y un ID
        const options = data.map((user, index) => ({
          index,
          id: user.idUsuario,  // Utiliza el nombre correcto del campo de ID
          value: `${user.NombreUsuario} ${user.ApellidoUsuario}`
        }));
        setPatientOptions(options);
      })
      .catch(error => console.error('Error al obtener datos de la API:', error));
  }, []);

  // Efecto para obtener los registros de síntomas cuando cambia el paciente seleccionado
  useEffect(() => {
    // Obtener el id del paciente seleccionado usando el índice
    const selectedPatientId = patientOptions[selectedPatientIndex]?.id;

    // Hacer la solicitud a la API para obtener los registros de síntomas del paciente seleccionado
    if (selectedPatientId) {
      fetch(`http://10.22.129.138:5001/registrosTodos/${selectedPatientId}`)
        .then(response => response.json())
        .then(data => {
          setSymptomRecords(data);
        })
        .catch(error => console.error('Error al obtener registros de síntomas:', error));
    }
  }, [selectedPatientIndex, patientOptions]);

  // Manejar el cambio de paciente seleccionado
  const handlePatientChange = (event) => {
    const selectedIndex = event.target.value;
    setSelectedPatientIndex(selectedIndex);
  };

  // Función para exportar registros a Excel
  const exportToExcel = () => {
    const selectedPatient = patientOptions[selectedPatientIndex];

    // Verificar si hay un paciente seleccionado
    if (!selectedPatient) {
      console.error('No hay paciente seleccionado para exportar.');
      return;
    }

    // Separar el nombre y apellido del paciente
    const patientName = selectedPatient.value.split(' ');
    const firstName = patientName[0];
    const lastName = patientName.slice(1).join(' ');

    // Crear un formato de registros para exportar
    const recordsForExport = symptomRecords.map(record => ({
      'Nombre': firstName,
      'Apellido': lastName,
      'Fecha': new Date(record.RegistroFecha).toLocaleString(),
      'Síntoma': record.RegistroSintoma,
      'Intensidad': record.RegistroIntensidad,
      'Nota': record.RegistroNota
    }));

    // Crear hoja de trabajo y libro
    const ws = XLSX.utils.json_to_sheet(recordsForExport);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Registros de Síntomas');

    // Guardar el archivo con un nombre específico (por ejemplo, registros_sintomas.xlsx)
    XLSX.writeFile(wb, 'registros_sintomas.xlsx');
  };

  return (
    <div className="option-picker-container">
      {/* Agregar el contenedor del logo en la esquina superior derecha */}
      <div className="logo-container">
        <img src="logoA.png" alt="Logo de la aplicación" />
      </div>

      <h1 className="option-picker-title">Hola doctor, seleccione un paciente</h1>
      <label htmlFor="patients" className="option-picker-label">
        Selecciona un paciente:
      </label>
      <select
        id="patients"
        value={selectedPatientIndex}
        onChange={handlePatientChange}
        className="option-picker-select"
      >
        {patientOptions.map((user) => (
          <option key={user.index} value={user.index}>
            {user.value}
          </option>
        ))}
      </select>
      <p className="option-picker-selected">Paciente seleccionado: {patientOptions[selectedPatientIndex]?.value}</p>

      <div className="symptom-records-container">
        <h2>Registros de Síntomas</h2>
        {symptomRecords.length === 0 ? (
          <p>No hay registros de síntomas para este paciente.</p>
        ) : (
          <table className="symptom-records-table">
            <thead>
              <tr>
                <th>Fecha</th>
                <th>Síntoma</th>
                <th>Intensidad</th>
                <th>Nota</th>
              </tr>
            </thead>
            <tbody>
              {symptomRecords.map((record, index) => (
                <tr key={index}>
                  <td>{new Date(record.RegistroFecha).toLocaleString()}</td>
                  <td>{record.RegistroSintoma}</td>
                  <td>{record.RegistroIntensidad}</td>
                  <td>{record.RegistroNota}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {/* Botón para exportar a Excel */}
      <Button variant="success" onClick={exportToExcel}>
        Exportar a Excel
      </Button>
    </div>
  );
}

export default OptionPicker;
