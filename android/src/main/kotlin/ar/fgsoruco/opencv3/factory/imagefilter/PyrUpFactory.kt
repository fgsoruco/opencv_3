package ar.fgsoruco.opencv3.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.core.Size
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream

class PyrUpFactory {
    //Module: Image Filtering
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, kernelSize: ArrayList<Int>, borderType: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(pyrUpS(pathString, kernelSize, borderType))
                2 -> result.success(pyrUpB(data, kernelSize, borderType))
                3 -> result.success(pyrUpB(data, kernelSize, borderType))
            }
        }

        //Module: Image Filtering
        private fun pyrUpS(pathString: String, kernelSize: ArrayList<Int>, borderType: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()
            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Size of the new image
                val size = Size((kernelSize[0]).toDouble(), (kernelSize[1]).toDouble())
                // pyrUp operation
                Imgproc.pyrUp(src, dst, size, borderType)
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
        private fun pyrUpB(data: ByteArray, kernelSize: ArrayList<Int>, borderType: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Size of the new image
                val size = Size((kernelSize[0]).toDouble(), (kernelSize[1]).toDouble())
                // pyrUp operation
                Imgproc.pyrUp(src, dst, size, borderType)
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