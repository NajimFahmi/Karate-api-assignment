package us.testRunner;
import com.intuit.karate.junit5.Karate;
public class APIReviewTestRunner {


	

	public class APITestRunner {

		@Karate.Test
		public Karate runTest() {
			return Karate.run("reviewFeatures").relativeTo(getClass());
			
		}
	}
}
