<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CKEditor学习</title>
	<!-- Make sure the path to CKEditor is correct. -->
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>	
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2>CKEditor学习</h2>
		<form>
            <textarea name="editor1" id="editor1" rows="10" cols="80">
                This is my textarea to be replaced with CKEditor 4.<br>
                <p>CKEditor 4 Quick Start Guide</p>

<p>The aim of this article is to get you up and running with CKEditor 4 in two minutes.</p>

<p>Install from the npm Registry</p>

<p>To install <a href="https://www.npmjs.com/package/ckeditor4" rel="noopener" target="_blank"><span style="color:#0066cc">the official CKEditor 4 npm package</span></a> run:</p>

<pre>
<code>npm install ckeditor4
</code></pre>

<p>For more detailed information you can check the guide on <a href="https://ckeditor.com/docs/ckeditor4/latest/guide/dev_package_managers.html"><span style="color:#0066cc">Installing CKEditor 4 with Package Managers</span></a>.</p>

<p>&nbsp;Download from Official Site</p>

<h3><a class="headerlink" href="https://ckeditor.com/docs/ckeditor4/latest/guide/dev_installation.html#download"><span style="color:#0066cc">#</span></a> Download</h3>

<p>Visit the official <a href="https://ckeditor.com/ckeditor-4/download/" rel="noopener" target="_blank"><span style="color:#0066cc">CKEditor 4 Download</span></a> site. For a production site we recommend you choose the default <strong>Standard Package</strong> and click the <strong>Download</strong> button to get the <code>.zip</code> installation file. If you want to try out more editor features, you can download the <strong>Full Package</strong> instead.</p>

<p>Adding CKEditor 4 to Your Page</p>

<p>If the sample works correctly, you are ready to build your own site with CKEditor 4 included.</p>

<p>To start, create a simple HTML page with a &lt; textarea&gt; element in it. You will then need to do two things:</p>

<ol>
	<li>Include the <code>&lt;script&gt;</code> element loading CKEditor 4 in your page.</li>
	<li>Use the <a href="https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR.html#method-replace"><code><span style="color:#0066cc">CKEDITOR.replace()</span></code></a> method to replace the existing <code>&lt;textarea&gt;</code> element with CKEditor 4.</li>
</ol>

<p>See the following example:</p>

<pre>
<code>&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
    &lt;head&gt;
        &lt;meta charset=&quot;utf-8&quot;&gt;
        &lt;title&gt;A Simple Page with CKEditor 4&lt;/title&gt;
        &lt;!-- Make sure the path to CKEditor is correct. --&gt;
        &lt;script src=&quot;../ckeditor.js&quot;&gt;&lt;/script&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;form&gt;
            &lt;textarea name=&quot;editor1&quot; id=&quot;editor1&quot; rows=&quot;10&quot; cols=&quot;80&quot;&gt;
                This is my textarea to be replaced with CKEditor 4.
            &lt;/textarea&gt;
            &lt;script&gt;
                // Replace the &lt;textarea id=&quot;editor1&quot;&gt; with a CKEditor 4
                // instance, using default configuration.
                <a href="https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR.html#method-replace"><span style="color:#0066cc">CKEDITOR.replace</span></a>( &#39;editor1&#39; );
            &lt;/script&gt;
        &lt;/form&gt;
    &lt;/body&gt;
&lt;/html&gt;</code></pre>

<p>---------------------<br />
网址：https://ckeditor.com/docs/ckeditor4/latest/guide/dev_installation.html</p>
                </textarea>
            <script>
                // Replace the <textarea id="editor1"> with a CKEditor 4 instance, using default configuration.
                CKEDITOR.replace( 'editor1' );
            </script>
        </form>

	</div>
</body>
</html>
<!-- 
https://ckeditor.com/docs/ckeditor4/latest/guide/dev_installation.html
 -->

