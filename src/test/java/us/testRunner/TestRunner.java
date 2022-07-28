package us.testRunner;
import com.intuit.karate.junit5.Karate;
public class TestRunner {


	

	public class APITestRunner {

		@Karate.Test
		public Karate getAPITest() {
			return Karate.run("reviewFeatures").relativeTo(getClass());
					//.tags("@End2End");
			
		}
	}
}
