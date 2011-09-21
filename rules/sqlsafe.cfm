<cfparam name="arguments.sqlSafe" type="string" default="keywords,functions,escape">
<cfparam name="arguments.sqlKeywords" type="string" default="delete,insert,select,update,drop,alter,create">

<cfif listFindNoCase( arguments.sqlSafe, "keywords" )>
	<cfloop index="arguments.word" list="#arguments.sqlKeywords#" delimiters=",">
		<cfif reFindNoCase( "\b#word#\b", arguments.value )>
			<cfif arguments.mutable>
				<cfset arguments.value = "">
			</cfif>
			<cfset arguments.message = "contained the restricted word ""#arguments.word#"", please retry">
			<cfbreak>
		</cfif>
	</cfloop>
</cfif>

<cfif listFindNoCase( arguments.sqlSafe, "functions" )>
	<cfif find( "(", arguments.value ) OR find( ")", arguments.value )>
		<cfif arguments.mutable>
			<cfset arguments.value = "">
		</cfif>
		<cfset arguments.message = "contained the restricted characters, please retry">
	</cfif>
</cfif>

<cfif ( listFindNoCase( arguments.sqlSafe, "escape" ) OR arguments.autoFix ) AND arguments.mutable>
	<cfset arguments.value = replace(arguments.value, "'", "&##39", "all" )>
	<!---<cfset arguments.value = replace( arguments.value, "'", "''", "all" )>--->
	<cfset arguments.value = replaceList( arguments.value, "--,/*,*/", "" )>
</cfif>	