/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sistema.DAO;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import javax.naming.NamingException;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import java.sql.ResultSetMetaData;
import java.util.Iterator;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
   
/**
 *
 * @author JSI-Rick
 */
public class GeneralDAO {

    private Connection conexion = null;
    private ResultSet resultSet = null;
    private String SQL = "";
    Element rootNode = null;
    ResultSetMetaData rsmd = null;
    private Context ctx;
    private DataSource ds;
    

    public GeneralDAO(String sentencias) throws IOException, JDOMException {

        SAXBuilder builder = new SAXBuilder();
        //Obtener ruta del archivo XML, solo lee el xml al mimso nivel que la clase
//        URL path =  this.getClass().getResource(sentencias);

        //Leer el XML
        Document document = (Document) builder.build(sentencias);
        //Obtener los elementos XML
        rootNode = document.getRootElement();
        
        try {
            this.ctx = new InitialContext();
            Context contx = (Context) this.ctx.lookup("java:comp/env");
            this.ds = ((DataSource) contx.lookup("jdbc/sito"));
        } catch (NamingException ex) {
            System.out.println(ex.getMessage());
        }

    }
    

    /**
     *
     * @param param
     * @param query
     * @return JsonArray
     * @throws SQLException
     * @throws ClassNotFoundException
     * @throws NamingException
     */
    public JsonArray Consultas(JsonArray param, String tag) throws SQLException, ClassNotFoundException, NamingException {
        JsonArray jsonarray = new JsonArray();
        PreparedStatement pst = null;
        this.conexion = null;
        
        
        try {
            
            if( this.conexion == null){
                this.conexion = this.ds.getConnection();
                
            }
                
          
            //Asigna que consulta de XML se necesita ejecutar
            List list = rootNode.getChildren(tag);

            //Validar que el XML viene con datos
            if (!list.isEmpty()) {

                //Obtener las etiquetas hijas 
                Element node = (Element) list.get(0);

                //Obtener la consuta ubicada e la etiqueta query
                this.SQL = node.getChildText("query");
                // System.out.println(this.SQL);
                if (!this.SQL.isEmpty()) {
                    
                     pst = this.conexion.prepareStatement(this.SQL); 

                    //Valida si hay parametos que agregar al PST
                    if (!param.isJsonNull()) {
                        int cont = 1;

                        for (JsonElement param1 : param) {

                            //Se asignan como String por deafault
                            pst.setString(cont, param1.getAsString());

                            cont++;
                        }
                    }

                    this.resultSet = pst.executeQuery();

                    //Obtiene las columnas de la consulta
                    rsmd = this.resultSet.getMetaData();

                    if (this.resultSet.next() == false) {
//                        JsonObject jsonObject = new JsonObject();
//                        jsonarray.add(jsonObject);
                    } else {

                        do {
                            JsonObject jsonObject = new JsonObject();

                            for (int i = 1; i <= rsmd.getColumnCount(); i++) {

                                //Tipo de dato que viene de SQL server, sino cae en ninuno se almacena como String
                                if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Integer) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getInt(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof String) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getString(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Boolean) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getBoolean(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Double) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getDouble(rsmd.getColumnLabel(i)));

                                } else {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getString(rsmd.getColumnLabel(i)));
                                }

                                // jsonObject.addProperty(rsmd.getColumnLabel(i), );
                                //System.out.println("Double: "+this.resultSet.getObject(rsmd.getColumnLabel(i)));
                            }

                            jsonarray.add(jsonObject);
                            
                        } while (this.resultSet.next());
                    }
                }

            }
        } catch (SQLException sq  ) {
            System.out.println("SQLException: "+this.getClass().getName() + " " + sq.getMessage() + " -- "+sq.getSQLState() );
            System.out.println("{" + this.SQL + "}");
            System.out.println(param.toString());
        } finally {
            if(pst != null){
                pst.close();
            }
            if (this.conexion != null) {
                this.conexion.close();

            }
        }
//        System.out.println(""+this.SQL);
//        System.out.println("query " + query);
//        System.out.println("record " + param.toString());
        
        return jsonarray;
    }
    
    /**
     * 
     * @param param
     * @param query
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     * @throws NamingException 
     */
    public JsonArray ConsultasSQL(JsonArray param, String query) throws SQLException, ClassNotFoundException, NamingException {
        JsonArray jsonarray = new JsonArray();
        PreparedStatement pst = null;
        this.conexion = null;
        try {
            
            if( this.conexion == null){
                this.conexion = this.ds.getConnection();
                
            }

                //Obtener la consuta ubicada e la etiqueta query
                this.SQL = query;
                // System.out.println(this.SQL);
                if (!this.SQL.isEmpty()) {
                    
                     pst = this.conexion.prepareStatement(this.SQL); 

                    //Valida si hay parametos que agregar al PST
                    if (!param.isJsonNull()) {
                        int cont = 1;

                        for (JsonElement param1 : param) {

                            //Se asignan como String por deafault
                            pst.setString(cont, param1.getAsString());

                            cont++;
                        }
                    }

                    this.resultSet = pst.executeQuery();

                    //Obtiene las columnas de la consulta
                    rsmd = this.resultSet.getMetaData();

                    if (this.resultSet.next() == false) {
//                        JsonObject jsonObject = new JsonObject();
//                        jsonarray.add(jsonObject);
                    } else {

                        do {
                            JsonObject jsonObject = new JsonObject();

                            for (int i = 1; i <= rsmd.getColumnCount(); i++) {

                                //Tipo de dato que viene de SQL server, sino cae en ninuno se almacena como String
                                if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Integer) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getInt(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof String) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getString(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Boolean) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getBoolean(rsmd.getColumnLabel(i)));

                                } else if (this.resultSet.getObject(rsmd.getColumnLabel(i)) instanceof Double) {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getDouble(rsmd.getColumnLabel(i)));

                                } else {

                                    jsonObject.addProperty(rsmd.getColumnLabel(i), this.resultSet.getString(rsmd.getColumnLabel(i)));
                                }

                                // jsonObject.addProperty(rsmd.getColumnLabel(i), );
//                                System.out.println("Double: "+this.resultSet.getObject(rsmd.getColumnLabel(i)));
                            }

                            jsonarray.add(jsonObject);
                            
                        } while (this.resultSet.next());
                    }
                }

            
        } catch (SQLException sq  ) {
            System.out.println(this.getClass().getName() + " " + sq.getMessage() + " -- ");
            System.out.println("{" + this.SQL + "}");
            System.out.println(param.toString());
        } finally {
            if(pst != null){
                pst.close();
            }
            if (this.conexion != null) {
                this.conexion.close();

            }
        }
//        System.out.println(""+this.SQL);
//        System.out.println("query " + query);
//        System.out.println("record " + param.toString());
        
        return jsonarray;
    }

    /**
     *
     * @param param
     * @param query
     * @return JsonArray
     * @throws ClassNotFoundException
     * @throws NamingException
     * @throws java.sql.SQLException
     */
    public int Registro(JsonArray param, String query) throws ClassNotFoundException, NamingException, SQLException {
        JsonArray jsonarray = new JsonArray();
        int resultado = 0;
        try {

            
                this.conexion = this.ds.getConnection();
            
            
            this.conexion.setAutoCommit(false);

            //Asigna que consulta de XML se necesita ejecutar
            List list = rootNode.getChildren(query);

            //Validar que el XML viene con datos
            if (!list.isEmpty()) {

                //Obtener las etiquetas hijas 
                Element node = (Element) list.get(0);

                //Obtener la consuta ubicada e la etiqueta query
                this.SQL = node.getChildText("query");

                PreparedStatement pst = this.conexion.prepareStatement(this.SQL);

                //Valida si hay parametos que agregar al PST
                if (!param.isJsonNull()) {

                    for (int i = 0; i < param.size(); i++) {

                        JsonObject param1 = param.get(i).getAsJsonObject();
                        int cont = 1;

                        for (Iterator iterator = param.get(i).getAsJsonObject().keySet().iterator(); iterator.hasNext();) {
                            String campo = (String) iterator.next();
                            pst.setString(cont, param1.get(campo).getAsString());

                            if (param1.size() == cont) {

                                pst.addBatch();
                            }

                            cont++;
                        }
                    }
                }
                
                int suma = 0;
                int[] registros = pst.executeBatch();
                for (int i : registros){
                    
                    if(i == 0){
                        //Se ejecut� la sentencia correctamente, pero no hubo filas afectadas
                        resultado = 0;
                    }else if(i >= 1 ){
                        //Se ejecut� la sentencia correctamente, y hubo un cierto n�umero de filas afectadas
                        resultado = 1;
                    }else if(i == -2){
                        //Se ejecut� la sentencia correctamente, pero JDBC no reconoce cuatas filas afectadas
                        resultado = 1;
                    }else if(i == -3){
                        //Error en la ejecuci�n del preparedStatement
                        resultado = -2;
                         this.conexion.rollback();
                    }
                    
                    
                    
                }
                
                if (!this.conexion.isClosed()) {
                    this.conexion.commit();
                    
                } else {
                    //Error al hacer commit  
                    resultado = -1;
                }
            }
        } catch (SQLException ex) {
            
            System.out.println(this.getClass().getName() + " " + ex.getMessage() + " -- ");
            System.out.println("{" + this.SQL + "}");
            System.out.println(param.toString());

            //Error en SQL, ciolaci�n de alguna condici�n 
            resultado = 2;
            this.conexion.rollback();
        } finally {

            if (this.conexion != null) {
                this.conexion.close();
            }
        }
//        System.out.println(""+param.toString());
//        System.out.println(""+this.SQL);
//        System.out.println("query " + query);
//        System.out.println("record " + resultado);
        return resultado;
    }
    /**
     *
     * @param param
     * @param query
     * @return JsonArray
     * @throws ClassNotFoundException
     * @throws NamingException
     * @throws java.sql.SQLException
     */
    public int RegistroCve(JsonArray param, String query) throws ClassNotFoundException, NamingException, SQLException {
        JsonArray jsonarray = new JsonArray();
        int resultado = 0;
        try {

            
                this.conexion = this.ds.getConnection();
            
            
            this.conexion.setAutoCommit(false);

            //Asigna que consulta de XML se necesita ejecutar
            List list = rootNode.getChildren(query);

            //Validar que el XML viene con datos
            if (!list.isEmpty()) {

                //Obtener las etiquetas hijas 
                Element node = (Element) list.get(0);

                //Obtener la consuta ubicada e la etiqueta query
                this.SQL = node.getChildText("query");

                PreparedStatement pst = this.conexion.prepareStatement(this.SQL, Statement.RETURN_GENERATED_KEYS);

                //Valida si hay parametos que agregar al PST
                if (!param.isJsonNull()) {

                    for (int i = 0; i < param.size(); i++) {

                        JsonObject param1 = param.get(i).getAsJsonObject();
                        int cont = 1;

                        for (Iterator iterator = param.get(i).getAsJsonObject().keySet().iterator(); iterator.hasNext();) {
                            String campo = (String) iterator.next();
                            pst.setString(cont, param1.get(campo).getAsString());

                            if (param1.size() == cont) {

                                resultado = pst.executeUpdate();
                            }

                            cont++;
                        }
                    }
                }
                
                int suma = 0;
                // int[] registros = pst.executeBatch();
                // for (int i : registros){
                try(ResultSet generatedKeys = pst.getGeneratedKeys()){
                    if(generatedKeys.next()){
                        resultado = generatedKeys.getInt(1);
                    }
                }
                
                if(resultado < 0){
                    this.conexion.rollback();
                }
                
                    
                // }
                
                if (!this.conexion.isClosed()) {
                    this.conexion.commit();
                    
                } else {
                    //Error al hacer commit  
                    resultado = -1;
                }
            }
        } catch (SQLException ex) {
            
            System.out.println(this.getClass().getName() + " " + ex.getMessage() + " -- ");
            System.out.println("{" + this.SQL + "}");
            System.out.println(param.toString());

            //Error en SQL, ciolaci�n de alguna condici�n 
            resultado = -2;
            this.conexion.rollback();
        } finally {

            if (this.conexion != null) {
                this.conexion.close();
            }
        }
//        System.out.println(""+param.toString());
//        System.out.println(""+this.SQL);
//        System.out.println("query " + query);
//        System.out.println("record " + resultado);
        return resultado;
    }
}
