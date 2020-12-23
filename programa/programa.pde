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
int motorI=5;
int motorD=6;
int puerta=7;
int sensorI=3;
int sensorD=4;
int sensorE=5;

//variables
int angCierre = 45;
int angAbierto= 100;
int pulsoBomba = 7;
int pulsoApBomba=25;



public void setup(){
  size(600, 400, JAVA2D);
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

}
