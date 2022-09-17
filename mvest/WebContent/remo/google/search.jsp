<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>

<%
	String CF_GOOGLE_SEARCH_KEY = "AIzaSyA8ohXkrUT6CV9t8D1Hq-8vpcn4XfRlpNw";
	String apiUrl = "https://www.googleapis.com/customsearch/v1";
	apiUrl += "?key="+CF_GOOGLE_SEARCH_KEY;
	apiUrl += "&cx=003480802014118702520:vnurwsm3lfq";
	apiUrl += "&q=test";
	apiUrl += "&lr=lang_ko";
	apiUrl += "&callback=hndlr";

%>
<!DOCUTYPE html>
<html>
  <head>
    <title>JSON Custom Search API Example</title>
  </head>
  <body>
    <div id="content"></div>
    <script>
      function hndlr(response) {
    	  alert(response.items.length);
      for (var i = 0; i < response.items.length; i++) {
        var item = response.items[i];
        // in production code, item.htmlTitle should have the HTML entities escaped.
        var r_title = item.title;
        var r_link = item.link;
        document.getElementById("content").innerHTML += "<br>" + item.htmlTitle;
      }
    }
    </script>
    <script src="<%=apiUrl %>">
   /*  <script src="https://www.googleapis.com/customsearch/v1?key=YOUR-KEY&cx=017576662512468239146:omuauf_lfve&q=cars&callback=hndlr"> */
    </script>
    <script>
  (function() {
    var cx = '003480802014118702520:vnurwsm3lfq';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
</script>
<gcse:search></gcse:search>
<div id="cse-body">
<div id="cse"><div class="gcse-searchresults" data-queryParameterName="q"> </div>
<div class="gsc-adBlock gsc-branding gsc-clear-button gsc-control-cse gsc-cursor-box gsc-imageResult-classic gsc-imageResult-column gsc-result gsc-results gsc-webResult gs-promotion gs-title gs-visibleUrl-long gs-visibleUrl-short gs-webResult hidden" id="gsc-hidden"></div>
</div>
</div>
  </body>
</html>