package apps;

import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamEvent;
import com.github.sarxos.webcam.WebcamListener;
import com.github.sarxos.webcam.WebcamResolution;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.JOptionPane;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;
import org.opencv.core.Point;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;

public class Main {
    public static void main(String[] args) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        
        // WEBCAM CAPTURE
        Webcam webcam = Webcam.getDefault();
        
        webcam.addWebcamListener(new WebcamListener() {
            @Override
            public void webcamOpen(WebcamEvent we) {
                System.out.println("Webcam Open");
            }

            @Override
            public void webcamClosed(WebcamEvent we) {
                System.out.println("Webcam Closed");
            }

            @Override
            public void webcamDisposed(WebcamEvent we) {
                System.out.println("Webcam Disposed");
            }

            @Override
            public void webcamImageObtained(WebcamEvent we) {
                System.out.println("Image Taken");
            }
        });
        
        webcam.setViewSize(WebcamResolution.VGA.getSize());
        
        webcam.open();
        try {
            ImageIO.write(webcam.getImage(), "PNG", new File("photo.png"));
        } catch (IOException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
        webcam.close();
        
        // FACE DETECTION
        String imgFile = "photo.png";
        Mat src = Imgcodecs.imread(imgFile);
        
        String xmlFile = "xml/lbpcascade_frontalface.xml";
        CascadeClassifier cc = new CascadeClassifier(xmlFile);
        
        MatOfRect faceDetection = new MatOfRect();
        cc.detectMultiScale(src, faceDetection);
        int detected = faceDetection.toArray().length;
        System.out.println("Detected Faces : " + detected);
        
        for(Rect rect: faceDetection.toArray()) {
            Imgproc.rectangle(src, new Point(rect.x, rect.y), new Point(rect.x + rect.width, rect.y + rect.height), new Scalar(0, 0, 255), 3);
        }
        
        Imgcodecs.imwrite("photox.png", src);
        System.out.println("Image Detection Finished");
        
        // MQTT
        String BROKER_URL = "tcp://broker.hivemq.com:1883";
        String data = (detected == 1) ? "true" : "false";
        MqttMessage msg = new MqttMessage((data).getBytes());
        msg.setQos(1);
        msg.setRetained(false);
        try {
            MqttClient client = new MqttClient(BROKER_URL, "Publisher");
            client.connect();
            System.out.println("Connected to BROKER");
            client.publish("/doorlock", msg);
            System.out.println("Message Sent : " + msg);
        } catch (MqttException e) {
            JOptionPane.showConfirmDialog(null, "MQTT ERROR \n" + e.getMessage());
        }
        
        // Database
        Random rand = new Random();
        int id_user = rand.nextInt(10 - 1) + 1;
        int id_security = (data.equals("true")) ? 1 : 2;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        String tgl_akses = dtf.format(now);
        String status = (data.equals("true")) ? "berhasil" : "gagal";
        
        try {
            String sql = "INSERT INTO tb_log_akses VALUES "
                   + "(default,'"+id_user+"','"+id_security+"','"+tgl_akses+"','"+status+"');";
            //System.out.println(sql);
            Connection conn = (Connection) DB.getConn();
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.execute();
            System.out.println("Database Log Updated");
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "SQL ERROR \n " + ex.getMessage());
        }
        
        System.exit(0);
    }
}

