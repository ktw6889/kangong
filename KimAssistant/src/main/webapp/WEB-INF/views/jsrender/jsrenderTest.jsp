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
<title>JSRender Test</title>

<script src="http://code.jquery.com/jquery-1.11.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jsrender.min.js" type="text/javascript"></script>
<link href="${ctx}/resources/css/demos.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resources/css/movielist.css" rel="stylesheet" type="text/css" />	

	<style type="text/css">
		.role { font-weight: bold; font-style: italic; background-color: Yellow; }
		.synopsis { background-color: white; padding: 15px; }
		.director { font-weight: bold; font-style: italic; color: red;  }
	</style>
	
</head>
<body>
<h3>Using {{for}} to render hierarchical data - inline nested template.</h3>

<table>
	<thead><tr><th>Title</th><th>Languages</th></tr></thead>
	<tbody id="movieList"></tbody>
</table>

<script id="movieTemplate" type="text/x-jsrender">
	<tr>
		<td>{{>title}}</td>
		<td>
			{{for languages}}
				<div class="{{:#index%2 ? 'even' : 'odd'}}"></div>
				<div>
					<em>{{>name}}</em>
				</div>
			{{else}}
				No alternate languages
			{{/for}}
		</td>
	</tr>
</script>

<script type="text/javascript">
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
				{ name: "Mandarin" },
				{ name: "Spanish" }
			]
		},
		{
			title: "The Inheritance",
			languages: [
				{ name: "English" },
				{ name: "German" }
			]
		},
		{
			title: "Local Story",
			languages: []
		},
		{
			title: "My Home Video"
		}
	];

	$( "#movieList" ).html(
		$( "#movieTemplate" ).render( movies )
	);
</script>

=================================================================================

<h3>Render template against local data</h3>

<div id="movieList2"></div>

<script id="movieTemplate2" type="text/x-jsrender">
	<div>
		{{:#index+1}}: <b>{{>name}}</b> ({{>releaseYear}})
	</div>
</script>

<script type="text/javascript">

	var movies2 = [
		{ name: "The Red Violin", releaseYear: "1998" },
		{ name: "Eyes Wide Shut", releaseYear: "1999" },
		{ name: "The Inheritance", releaseYear: "1976" }
	];

	// Render the template with the movies data and insert
	// the rendered HTML under the "movieList" element
	$( "#movieList2" ).html(
		$( "#movieTemplate2" ).render( movies2 )
	);
	</script>

=================================================================================

<h3>Compiling named templates from strings</h3>

<button id="switchBtn">Show full details</button><br/>
<br />
<table>
	<tbody id="movieList3"></tbody>
</table>

<script type="text/javascript">
	var movies3 = [
		{ name: "The Red Violin", releaseYear: "1998", director: "Francois Girard" },
		{ name: "Eyes Wide Shut", releaseYear: "1999", director: "Stanley Kubrick" },
		{ name: "The Inheritance", releaseYear: "1976", director: "Mauro Bolognini" }
	];

	/* Compile markup as named templates */
	$.templates({
		titleTemplate: "<tr><td colspan=3>{{>name}}</td></tr>",
		detailTemplate: "<tr><td>{{>name}}</td><td>Released: {{>releaseYear}}</td><td>director: {{>director}}</td></tr>"
	});

	var details = true;

	function switchTemplates() {
		var html,
			button = $("#switchBtn");

		details = !details;

		/* Render using the other named template */
		if ( details ) {
			button.text( "Show titles only" );
			html = $.render.detailTemplate( movies3 );
		} else {
			button.text( "Show full details" );
			html = $.render.titleTemplate( movies3 );
		}
		$( "#movieList3" ).html( html );
	}

	$( "#switchBtn" ).click( switchTemplates );

	switchTemplates();
</script>

=================================================================================

<h3>Using {{: }} or {{> }} to render data values with optional conversion or encoding</h3>

<ul>
<li><em>{{:value}}</em> &mdash; does not convert. Used to render values that include html markup.  json데이터에 있는 html태그 html로 인식해서 출력</li>
<li><em>{{loc:value lang="..."}}</em> &mdash; Uses custom converter. 사용자가 언어에 따라 내용을 바꿀수 있다. (아래 정의부분을 통해서 변경 가능). 단순 문자 바꿈도 될듯</li>
<li><em>{{html:value}}</em> &mdash; Converts using built-in HTML encoder. (Better security within element content, but slight perf cost).</li>
<li><em>{{>value}}</em> &mdash; Alternative syntax for built-in HTML encoder.  json데이터에 있는 html태그 text로 출력</li>
<li><em>{{attr:availability}}</em> &mdash; Converts using built-in attribute encoder. (Better security within attributes). 요소의 속성값으로 사용 ex) 위 예제에선 <tr title="Available in 'X&amp;Y' Cinemas"></li>
<li><em>{{url:value lang="..."}}</em> &mdash; Converts using built-in URL encoder.</li>
</ul><br />

<div class="box label">
<b>Note:</b> A common use for converters is to protect against injection attacks from untrusted data.
<br />It is generally best to use <b>{{> }}</b> when rendering data within element content, if the data is not intended to provide markup for insertion in the DOM.
<br />In the context of HTML attributes, use <b>{{attr: }}</b>.</div>

<table>
	<thead><tr><th>Title (loc:English)</th><th>Title (loc:French)</th><th>No Convert</th><th>HTML Encode</th></tr></thead>
	<tbody id="movieList4"></tbody>
</table>

<script id="movieTemplate4" type="text/x-jsrender">
	<tr title="{{attr:availability}}">
		<td>{{loc:title lang='EN'}}</td>
		<td>{{loc:title lang='FR'}}</td>
		<td class="synopsis">{{:synopsis}}</td>
		<td class="synopsis">{{>synopsis}}</td>
	</tr>
</script>


<script type="text/javascript">

	var movies4 = [
		{
			availability: "Available in 'X&Y' Cinemas",
			title: "Meet Joe Black",
			synopsis: "The <span class='role'>grim reaper</span> (<a href='http://www.netflix.com/RoleDisplay/Brad_Pitt/73919'>Brad Pitt</a>) visits <span class='role'>Bill Parrish</span> (<a href='http://www.netflix.com/RoleDisplay/Anthony_Hopkins/43014'>Anthony Hopkins</a>)..."
		},
		{
			availability: "Available at < 20kms from London",
			title: "Eyes Wide Shut",
			synopsis: "Director <span class='director'>Stanley Kubrick's</span> final film: <br/><br/><img src='http://cdn-4.nflximg.com/US/boxshots/large/5670434.jpg'/>"
		}
	];

	$.views.converters({
		loc: function (value) {
			var result = "";

			switch(this.tagCtx.props.lang) {
				case "EN":
					result = value;
					break;

				case "FR":
					switch (value) {
						case "Meet Joe Black":
							result = "Rencontrez Joe Black";
							break;

						case "Eyes Wide Shut":
							result = "Les Yeux Grand Fermés";
							break;
					}
				break;
			}
			return result;
		}
	});
	$( "#movieList4" ).html(
		$( "#movieTemplate4" ).render( movies4 )
	);

</script>

=================================================================================

<h3>Using {{if}} and {{else}} to render conditional sections.</h3>

<table>
	<thead><tr><th>title</th><th>languages</th></tr></thead>
	<tbody id="movieList5"></tbody>
</table>

<script id="movieTemplate5" type="text/x-jsrender">
	<tr>
		<td>{{>title}}</td>
		<td>
			{{if languages}}
				Alternative languages: <em>{{>languages}}</em>.
			{{else subtitles}}
				Original language only... <br/>subtitles in <em>{{>subtitles}}</em>.
			{{else}}
				Original version only, without subtitles.
			{{/if}}
		</td>
	</tr>
</script>


<script type="text/javascript">

	var movies5 = [
		{
			title: "Meet Joe Black",
			languages: "English and French",
			subtitles: "English"
		},
		{
			title: "Eyes Wide Shut",
			subtitles: "French and Spanish"
		},
		{
			title: "The Mighty"
		},
		{
			title: "City Hunter",
			languages: "Mandarin and Chinese"
		}
	];

	$( "#movieList5" ).html(
		$( "#movieTemplate5" ).render( movies5 )
	);

</script>

=================================================================================

<h3>Using {{for}} to render hierarchical data - inline nested template.</h3>

<table>
	<thead><tr><th>Title</th><th>Languages</th></tr></thead>
	<tbody id="movieList6"></tbody>
</table>

<script id="movieTemplate6" type="text/x-jsrender">
	<tr>
		<td>{{>title}}</td>
		<td>
			{{for languages}}
				<div class="{{:#index%2 ? 'even' : 'odd'}}"></div>
				<div>
					<em>{{>name}}</em>
				</div>
			{{else}}
				No alternate languages
			{{/for}}
		</td>
	</tr>
</script>

<script type="text/javascript">

	var movies6 = [
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
				{ name: "Mandarin" },
				{ name: "Spanish" }
			]
		},
		{
			title: "The Inheritance",
			languages: [
				{ name: "English" },
				{ name: "German" }
			]
		},
		{
			title: "Local Story",
			languages: []
		},
		{
			title: "My Home Video"
		}
	];

	$( "#movieList6" ).html(
		$( "#movieTemplate6" ).render( movies6 )
	);

</script>

=================================================================================

<h3>Template composition. Using external templates for block tags, such as {{for}} and {{if}}.</h3>

<table>
	<thead><tr><th>Synopsis</th><th>Fixed Template</th><th>Template specified in data</th><th>Conditional Template</th><th>Wrapper Template</th><th>Repeating Wrapper Template</th></tr></thead>
	<tbody id="movieList7"></tbody>
</table>

<script id="movieTemplate7" type="text/x-jsrender">
	<tr>
		{{include tmpl="#headerTemplate"/}}
		<td>
			{{for languages tmpl="#columnTemplate"/}}
		</td>
		<td>
			{{for languages tmpl=tmpl/}}
		</td>
		<td>
			{{for languages tmpl='#conditionalTemplate'/}}
		</td>
		{{include tmpl="#sectionWrapperTemplate"}}
			{{>title}}
		{{/include}}
		<td>
			{{for languages tmpl='#indexWrapperTemplate'}}
				<b>{{>name}}</b>
			{{/for}}
		</td>
	</tr>
</script>

<script id="headerTemplate" type="text/x-jsrender">
	<td>{{>title}}</td>
</script>

<script id="sectionWrapperTemplate" type="text/x-jsrender">
	<td>Section: <em>{{include tmpl=#content/}}</em></td>
</script>

<script id="columnTemplate" type="text/x-jsrender">
	<div>
		<em>{{>name}}</em>
	</div>
</script>

<script id="rowTemplate" type="text/x-jsrender">
	<span>
		<b>{{>name}}</b>
	</span>
</script>

<script id="conditionalTemplate" type="text/x-jsrender">
	{{if name.charAt(0)==='E' tmpl='#rowTemplate'}}
	{{else tmpl='#columnTemplate'}}
	{{/if}}
</script>

<script id="indexWrapperTemplate" type="text/x-jsrender">
	<div>
		{{:#index}}:
		{{include tmpl=#content/}}
	</div>
</script>

<script type="text/javascript">

	var movies7 = [
		{
			title: "Meet Joe Black",
			languages: [
				{ name: "English" },
				{ name: "French" }
			],
			tmpl: "#columnTemplate"
		},
		{
			title: "Eyes Wide Shut",
			languages: [
				{ name: "French" },
				{ name: "Esperanto" },
				{ name: "Spanish" }
			],
			tmpl: "#rowTemplate"
		},
		{
			title: "The Inheritance",
			languages: [
				{ name: "English" },
				{ name: "German" }
			],
			tmpl: "#columnTemplate"
		}
	];

	$( "#movieList7" ).html(
		$( "#movieTemplate7" ).render( movies7 )
	);

</script>

=================================================================================

<h3>Accessing paths</h3>

<script id="peopleTemplate" type="text/x-jsrender">

	<b>{{:#index+1}}:</b> {{>firstName}} {{>lastName}}:

	<br/>
	{{for address tmpl="#addressTemplate"}}{{else}}
		Address missing
	{{/for}}

	<div>
		Phones:
		{{for ~combine(phones, cells)}}
			<b>{{>#data}}</b> ({{>#parent.parent.data.firstName}}'s)
		{{else}}
			{{>#parent.data.firstName}} has no phones or cells
		{{/for}}

{{!-- or provide an alias to get to firstName from nested content
		Phones:
		{{for ~combine(phones, cells) ~frstNm=firstName}}
			<b>{{>#data}}</b> ({{>~frstNm}}'s)
		{{else}}
			{{>~frstNm}} has no phones or cells
		{{/for}}
--}}
	</div>

	<br/>

	<i>
		{{>firstName}}

		{{if address && address.street}}  {{!-- address may be null or undefined --}}
			lives in {{>address.street}}.
		{{else}}
			has no address...
		{{/if}}
	</i>
	<hr/>

</script>

<script id="addressTemplate" type="text/x-jsrender">
<div>
	{{if street}}
		{{>street}}
	{{else}}
		<i>Somewhere</i> in
	{{/if}}
	{{>city}}
</div>
</script>

<div id="peopleList"></div>

<script type="text/javascript">
	var people = [
		{
			firstName: "Pete",
			lastName: "Ruffles",
			address: {
				city: "Bellevue"
			},
			cells: ["425 666 3455", "425 222 1111"]
		},
		{
			firstName: "Xavier",
			lastName: "NoStreet",
			phones: ["222 666 3455"],
			cells: ["444 666 3455", "999 222 1111"]
		},
		{
			firstName: "Christie",
			lastName: "Sutherland",
			address: {
				street: "222 2nd Ave NE",
				city: "Redmond"
			}
		}
	];

	$.views.tags({
		notLast: function( content ) {
			var array = this.parent.data;
			return array[ array.length - 1 ] === this.data ? "" : content( this );
		}
	});

	$.views.helpers({
		combine: function( arr1, arr2 ) {
			return arr1 && arr2 ? arr1.concat(arr2) : arr1 || arr2;
		}
	});

	$( "#peopleList" ).html(
		$( "#peopleTemplate" ).render( people )
	);

</script>

</body>
</html>