import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import g4p_controls.*;




String fecha;
String hora;
String id;
Arduino ardu;


//conexiones
int buzzer=2;
int led=4;
int ledBuzzer=7;
int ledLuz=8;
int bombaI=5;
int bombaD=6;
int puerta=7;
int sensorI=0;
int sensorD=1;
int sensorE=5;
int esperaPuerta=10;

//variables
int angCierre = 45;
int angAbierto= 100;
int pulsoBomba = 7;
int pulsoApBomba=25;
int numeroIteraciones;
int iteracion=1;
int experimentosLuz;
int experimentosBuzzer;
boolean experimentoCorriendo=false;
boolean sensorTocadoI=false;
boolean sensorTocadoD=false;
boolean sensorTocadoIn=false;
boolean esperandoPrueba=false;
boolean cancelado=false;
boolean listaExperimentos[];
String arrIniciar[]= {"Aleatorio","Luz","Buzzer"};
String nomArchivo;

public void setup(){
  size(690, 400, JAVA2D);
  createGUI();
  customGUI();
  thread("fecha");
  thread("hora");
  thread("actualizarFechaHora");
}

public void draw(){
  background(230);
}

public void customGUI(){
  btnDesconectar.setVisible(false);
  fldVolumenIzquierdo.setNumericType(G4P.DECIMAL);
  fldVolumenDerecho.setNumericType(G4P.DECIMAL);
  fldEnsayosLuz.setNumericType(G4P.INTEGER);
  fldEnsayosLuz.setNumericType(G4P.INTEGER);
  fldDuracionEstimulo.setNumericType(G4P.INTEGER);
  btnDetener.setVisible(false);
}
