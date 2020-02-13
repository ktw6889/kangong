<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>JSRender Test2</title>

<script src="http://code.jquery.com/jquery-1.11.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jsrender.min.js" type="text/javascript"></script>
<link href="${ctx}/resources/css/demos.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resources/css/movielist.css" rel="stylesheet" type="text/css" />	

</head>
<body>

<h3>Custom Tags</h3>

<table>
  <thead><tr>
  <th>Render method wrapping content</th>
  <th>Render method with external content</th>
  <th>Tag template wrapping content</th>
  <th>Tag template with external content</th>
  <th>Sort tag: Reverse order</th>
  <th>Sort tag: Languages (external content)</th></tr></thead>
  <tbody id="movieList"></tbody>
</table>

<script id="movieTemplate" type="text/x-jsrender">
  <tr>
    <td>
      {{fntag}}{{>title}}{{/fntag}}
    </td>
    <td>
      {{fntag tmpl="#wrappedTmpl"/}}
    </td>
    <td>
      {{tmpltag}}{{>title}}{{/tmpltag}}
    </td>
    <td>
      {{tmpltag template="#wrappedTmpl"/}}
    </td>
    <td>
      {{sort languages reverse=true}}
        <div>
          <b>{{>name}}</b>
        </div>
      {{/sort}}
    </td>
    <td>{{sort languages tmpl="#sortedTmpl"/}}</td>
  </tr>
</script>

<script id="sortedTmpl" type="text/x-jsrender">
  <div>{{>name}}</div>
</script>
<script id="wrappedTmpl" type="text/x-jsrender">{{>title}}</script>

<script>
$.views.tags({

  // Tag with a render method to return HTML content,
  // including data, and the rendered inline content
  fntag: function() {
    return "Title:<br/><b>" +
      this.tagCtx.render() +
      "</b>.<br/>" +
      this.tagCtx.view.data.languages.length +
      "&nbsp;languages.";
  },

  // Tag with no render method. Just a template to
  // render HTML content including data, and the
  // rendered inline content.

  // To use as a self-closing tag, with an external
  // template, use named "template" property.
  tmpltag: {
    template: "Title:<br/><b>" +
      "{{include " +
          // block content
            "tmpl=#content" +
          // or external content
            "||~tag.tagCtx.props.template/}}" +
      "</b>.<br/>{{:languages.length}}&nbsp;languages."
  },

  // Tag with render method to reverse-sort an array
  sort: function(array){
    var ret = "";
    if (this.tagCtx.props.reverse) {
      // Render in reverse order
      for (var i = array.length; i; i--) {
        ret += this.tagCtx.render(array[i - 1]);
      }
    } else {
      // Render in original order
      ret += this.tagCtx.render(array);
    }
    return ret;
  }

});

var movies = [
  {
    title: "Meet Joe Black",
    languages: [
      { name: "English" },
      { name: "French" }
    ]
  },
  {
    title: "Eyes Wide Shut",
    languages: [
      { name: "French" },
      { name: "German" },
      { name: "Spanish" }
    ]
  }
];

$("#movieList").html(
  $("#movieTemplate").render(movies)
);

</script>

===============================================================================

<h3>Helper functions</h3>

<pre>
{{>~format(name, "upper")}}

$.views.helpers({

    format: function( val, format ) {
        ...
        return val.toUpperCase();
        ...
    },

    ...
});
</pre>

<!--=================== Demo ===================-->

<!------------------ Templates ------------------>

<table>
	<thead><tr><th>Title</th><th>Languages</th></tr></thead>
	<tbody id="movieList2"></tbody>
</table>

<script id="movieTemplate2" type="text/x-jsrender">
	<tr>
		<td>{{>~format(title, "upper")}}</td>
		<td>
			{{for languages}}
				{{>~format(name, "lower")}}
			{{/for}}
		</td>
	</tr>
</script>

<!------------------ Script ------------------>

<script type="text/javascript">
	$.views.helpers({
		format: function( val, format ) {
			var ret;
			switch( format ) {
				case "upper":
					return val.toUpperCase();
				case "lower":
					return val.toLowerCase();
			}
		}
	});

	var movie2 = {
			title: "Eyes Wide Shut",
			languages: [
				{ name: "French" },
				{ name: "German" },
				{ name: "Spanish" }
			]
		};

	$( "#movieList2" ).html(
		$( "#movieTemplate2" ).render( movie2 )
	);

</script>

=================================================================================================================

<h3>Comparison tests</h3>

<pre>
{{if !(languages && languages.length)}}...{{/if}}

{{if languages==null}}...{{/if}}
</pre>

<!--================ Demo ================-->
<table>
	<thead><tr><th>Title</th><th>{{if !(languages && languages.length)}}</th><th>{{if a==null}}</th></tr></thead>
	<tbody id="movieList3"></tbody>
</table>

<script id="movieTemplate3" type="text/x-jsrender">
	<tr>
		<td>{{>title}}</td>
		<td>
			{{if !(languages && languages.length) tmpl="#messageTmpl"/}}
		</td>
		<td>
			{{if languages==null tmpl="#messageTmpl"/}}
		</td>
	</tr>
</script>

<script id="messageTmpl" type="text/x-jsrender">
	<b>Warning:</b> <em>No alternate languages</em>
</script>


<script type="text/javascript">
	var movies3 = [
		{
			title: "Meet Joe Black",
			languages: null
		},
		{
			title: "The Mighty",
			languages: []
		},
		{
			title: "Eyes Wide Shut",
			languages: [
				{ name: "French" },
				{ name: "German" },
				{ name: "Spanish" }
			]
		}
	];

	$( "#movieList3" ).html(
		$( "#movieTemplate3" ).render( movies3 )
	);

</script>

============================================================================================================

<h3>Example Scenario: Accessing parent data.</h3>

<!---------------------- First Example ---------------------->

<div class="subhead">Stepping up through the views (tree of nested rendered templates)</div>

<pre>
var model = {
    specialMessage: function(...) { ... },
    theater: "Rialto",
    movies: [ ... ]
}

{{for movies11}}
    &lt;tr>
        &lt;td>'{{>title}}': showing at the '{{>#parent.parent.data.theater}}'&lt;/td>
</pre>

<table>
	<thead><tr><th>Title</th><th>Languages (+specialMessage)</th></tr></thead>
	<tbody id="movieList11"></tbody>
</table>

<!---------------------- Second Example ---------------------->

<div class="subhead">Setting contextual template parameters, accessible in all nested contexts as <em>~nameOfParameter</em>:</div>

<pre>
{{for movies11 ~theater=theater}}
    &lt;tr>
        &lt;td>'{{>title}}': showing at the '{{>~theater}}'&lt;/td>
</pre>

<table>
	<thead><tr><th>Title</th><th>Languages (+specialMessage)</th></tr></thead>
	<tbody id="movieList12"></tbody>
</table>

<!---------------------- Third Example ---------------------->

<div class="subhead">Using the top-level data, accessible in all nested contexts as <em>~root</em>:</div>

<pre>
{{for movies11}}
    &lt;tr>
        &lt;td>'{{>title}}': showing at the '{{>~root.theater}}'&lt;/td>
</pre>

<table>
	<thead><tr><th>Title</th><th>Languages (+specialMessage)</th></tr></thead>
	<tbody id="movieList13"></tbody>
</table>

<!--=================== Demo ===================-->

<!------------------ Templates ------------------>

<script id="movieTemplate11" type="text/x-jsrender">
	{{for movies11}}
		<tr>
			<td>'{{>title}}': showing at the '{{>#parent.parent.data.theater}}'</td>
			<td>
				{{if languages}}
					{{for languages}}
						{{>#data}}{{>#parent.parent.parent.parent.parent.data.specialMessage(#data, #parent.parent.data.title)}}<br/>
					{{/for}}
				{{/if}}
			</td>
		</tr>
	{{/for}}
</script>

<script id="movieTemplate12" type="text/x-jsrender">
	{{for movies11 ~theater=theater ~specialMessage=specialMessage}}
		<tr>
			<td>'{{>title}}': showing at the '{{>~theater}}'</td>
			<td>
				{{for languages ~title=title}}
					{{>#data}}{{>~specialMessage(#data, ~title)}}<br/>
				{{/for}}
			</td>
		</tr>
	{{/for}}
</script>

<script id="movieTemplate13" type="text/x-jsrender">
	{{for movies11}}
		<tr>
			<td>'{{>title}}': showing at the '{{>~root.theater}}'</td>
			<td>
				{{for languages ~title=title}}
					{{>#data}}{{>~root.specialMessage(#data, ~title)}}<br/>
				{{/for}}
			</td>
		</tr>
	{{/for}}
</script>

<!------------------ Script ------------------>

<script type="text/javascript">

	var model = {
		specialMessage: function(language, title) {
			if (language === "French" && title === "City Hunter") { return ": (special offer)"; }
		},
		theater: "Rialto",

		movies11: [
			{
				title: "Meet Joe Black",
				languages: [
					"English",
					"French"
				]
			},
			{
				title: "City Hunter",
				languages: [
					"Mandarin",
					"French",
					"Chinese"
				]
			}
		]
	};

	$( "#movieList11" ).html(
		$( "#movieTemplate11" ).render( model )
	);

	$( "#movieList12" ).html(
		$( "#movieTemplate12" ).render( model )
	);

	$( "#movieList13" ).html(
		$( "#movieTemplate13" ).render( model )
	);

</script>

======================================================================================================

<h3>Template context: Passing in additional helpers to a render() call</h3>

<div class="subhead">Passing in contextual variables or helper functions, using the helpersOrContext parameter of <em>...render( data, helpersOrContext );</em></div>
<pre>
$( selector ).render( data, {
    reverseSort: reverse,
    format: myFormatFunction,
    buttonCaption: function(val) {
        ...
    }
})
</pre>

<div class="subhead">Use <em>~name</em> to access context variables or helpers by name - whether passed in with options,</div>
<div class="subhead">registered globally as helpers, or registered as helpers for a specific template.</div>

<pre>
&lt;th>&lt;button>{{>~buttonCaption('sort')}}&lt;/button>&lt;/th>
...
&lt;td>{{>~format(title)}}&lt;/td>
...
&lt;td>{{sort languages reverse=~reverseSort}}...{{/sort}}&lt;/td>
</pre>

<!--================ Demo ================-->

<table id="movieList4"></table>
<br />


<script id="movieTemplate4" type="text/x-jsrender">
	<thead>
		<tr>
			<th>Title <button id="formatBtn">{{>~buttonCaption('case')}}</button></th>
			<th><button id="sortBtn">{{>~buttonCaption('sort')}}</button></th>
		</tr>
	</thead>
	<tbody>
		{{for #data}}
		<tr>
			<td>{{>~format(title)}}</td>
			<td>
				{{sort languages reverse=~reverseSort}}
					<div>
						<b>{{>name}}</b>
					</div>
				{{/sort}}
			</td>
		</tr>
		{{/for}}
	</tbody>
</script>

<script type="text/javascript">

	$.views.tags({

		// Tag to reverse-sort an array
		sort: function( array ){
			var ret = "";
			if ( this.tagCtx.props.reverse ) {
				// Render in reverse order
				for ( var i = array.length; i; i-- ) {
					ret += this.tagCtx.render( array[ i - 1 ] );
				}
			} else {
				// Render in original order
				ret += this.tagCtx.render( array );
			}
			return ret;
		}

	});

	var reverse = false,
		upperCase = false,
		movies4 = [
			{
				title: "Meet Joe Black",
				languages: [
					{ name: "English" },
					{ name: "French" }
				]
			},
			{
				title: "Eyes Wide Shut",
				languages: [
					{ name: "French" },
					{ name: "German" },
					{ name: "Spanish" }
				]
			}
		];

	function myFormatFunction(value) {
		return upperCase ? value.toUpperCase() : value.toLowerCase();
	}

	$("#movieList4")
		.on("click", "#sortBtn", function(){
			reverse = !reverse;
			renderList();
		})
		.on("click", "#formatBtn", function(){
			upperCase = !upperCase;
			renderList();
		});

	function renderList() {
		$( "#movieList4" ).html(
			$( "#movieTemplate4" ).render( [movies4], {
				reverseSort: reverse,
				format: myFormatFunction,
				buttonCaption: function(val) {
					if (val === 'sort') {
						return reverse ? "Sort increasing" : "Sort decreasing";
					}
					return upperCase ? "to lower" : "to upper";
				}
			})
		);
	}
	renderList();
</script>

</body>
</html>