name := "blog"
version := "v1.0"

routesGenerator := InjectedRoutesGenerator

scalaVersion := "2.11.8"

lazy val `blog` = (project in file(".")).enablePlugins(PlayScala)


resolvers ++= Seq("snapshots", "releases").map(Resolver.sonatypeRepo)


//-=-=-=-=-=-=-=-==-==-==-==-=-=-=-=-=-=-
//Dependencies
//-=-=-=-=-=-=-=-==-==-==-==-=-=-=-=-=-=-
libraryDependencies ++= {
  val sendgridV = "3.0.1"
  val playSlickV = "2.0.2"

  Seq(
    "com.typesafe.play" %% "play-slick" % playSlickV

    //dependency included to demonstrate exclude statements
    , ("com.sendgrid" % "sendgrid-java" % sendgridV)
      .exclude("commons-logging", "commons-logging")
  )
}

//-=-=-=-=-=-=-=-==-==-==-==-=-=-=-=-=-=-
//Assembly
//-=-=-=-=-=-=-=-==-==-==-==-=-=-=-=-=-=-

//how to crete a general merge strategy
assemblyMergeStrategy in assembly := {
  case "META-INF/io.netty.versions.properties" => MergeStrategy.first
  case x =>
    val oldStrategy = (assemblyMergeStrategy in assembly).value
    oldStrategy(x)
}

assemblyOption in assembly := (assemblyOption in assembly).value
  .copy(includeScala = false, includeDependency = false)

