package is.rud.htmlunit;

import com.gargoylesoftware.htmlunit.*;
import com.gargoylesoftware.htmlunit.util.*;

import java.util.*;
import java.lang.*;
import java.io.*;

public class Zapp {

  private static com.gargoylesoftware.htmlunit.IncorrectnessListener incorrectnessListener_ = new RIncorrectnessListener();
  private static com.gargoylesoftware.css.parser.CSSErrorHandler cssErrorHandler_ = new RDefaultCssErrorHandler();

  public static List<WebResponse> getRequestsFor(String url, long jsDelay, int timeout, Boolean css, Boolean images) throws IOException {

    final WebClient webClient = new WebClient(BrowserVersion.CHROME);

    webClient.setCssErrorHandler(cssErrorHandler_);
    webClient.setIncorrectnessListener(incorrectnessListener_);

    WebClientOptions wco = webClient.getOptions();

    wco.setThrowExceptionOnScriptError(false);
    wco.setCssEnabled(css);
    wco.setDownloadImages(images);
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

