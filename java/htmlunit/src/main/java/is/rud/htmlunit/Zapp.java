package is.rud.htmlunit;

import com.gargoylesoftware.htmlunit.*;
import com.gargoylesoftware.htmlunit.util.*;
import java.util.*;
import java.lang.*;
import java.io.*;

public class Zapp {

  public static List<WebResponse> getRequestsFor(String url, long jsDelay, int timeout) throws IOException {

    final WebClient webClient = new WebClient(BrowserVersion.CHROME);

    WebClientOptions wco = webClient.getOptions();
    wco.setThrowExceptionOnScriptError(false);
    wco.setCssEnabled(true);
    wco.setDownloadImages(true);
    wco.setTimeout(timeout);

    final List<WebResponse> list = new ArrayList<>();

    new WebConnectionWrapper(webClient) {
      @Override
      public WebResponse getResponse(final WebRequest request) throws IOException {
        final WebResponse response = super.getResponse(request);
        list.add(response);
        return response;
      }
    };

    webClient.getPage(url);
    webClient.waitForBackgroundJavaScript(jsDelay);

    return(list);

  }

}

