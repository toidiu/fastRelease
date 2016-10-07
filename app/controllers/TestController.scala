package controllers

import akka.util.Timeout
import play.api.mvc.{Action, Controller}

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.Future
import scala.concurrent.duration._
import scala.language.postfixOps

/**
  * Created by toidiu on 9/20/16.
  */
class TestController extends Controller {

  implicit val timeout = new Timeout(20 seconds)


  def test() = Action.async { req =>
    Future(Ok("test"))
  }

}
