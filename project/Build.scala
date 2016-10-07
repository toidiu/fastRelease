import sbt._
import Keys._


/**
 * Created by toidiu on 7/3/16.
 */
object AppBuild extends Build{

  javaOptions in Test ++= Option(System.getProperty("config.file")).map("-Dconfig.file=" + _).toSeq
//  javaOptions in Test ++= Option(System.getProperty("config.file")).map("-Dconfig.file=" + _).toSeq
//  javaOptions in Test ++= Seq("-Dconfig.file=test.conf")

}

