import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import g4p_controls.*;


String fecha;
String hora;
String id;
Arduino duino;


//conexiones
int OUT1=5;
int OUT2=6;


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

}
