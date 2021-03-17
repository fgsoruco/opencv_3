package ar.fgsoruco.opencv3.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream

class ScharrFactory {
    //Module: Image Filtering
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, depth: Int, dx: Int, dy: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(scharrS(pathString, depth, dx, dy))
                2 -> result.success(scharrB(data, depth, dx, dy))
                3 -> result.success(scharrB(data, depth, dx, dy))
            }
        }

        //Module: Image Filtering
        private fun scharrS(pathString: String, depth: Int, dx: Int, dy: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()
            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Scharr operation
                Imgproc.Scharr(src, dst, depth, dx, dy)

                // instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()
                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }

        //Module: Image Filtering
        private fun scharrB(data: ByteArray, depth: Int, dx: Int, dy: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Scharr operation
                Imgproc.Scharr(src, dst, depth, dx, dy)

                // instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()
                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }
    }
}