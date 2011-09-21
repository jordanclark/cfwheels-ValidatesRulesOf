<cfparam name="arguments.contains" type="string">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<!--- <cfparam name="arguments.containsReplace" type="string"> --->
<cfparam name="arguments.containsError" type="string" default="contained invalid information">

<cfif arguments.caseSensitive>
	<cfif reFind( arguments.contains, arguments.value )>
		<cfif NOT arguments.autoFix>
			<cfset arguments.message = arguments.containsError>
		</cfif>
		<cfif arguments.mutable AND structKeyExists( arguments, "containsReplace" )>
			<cfset arguments.value = reReplace( arguments.value, arguments.contains, arguments.containsReplace, "all" )>
		</cfif>
	</cfif>
<cfelse>
	<cfif reFindNoCase( arguments.contains, arguments.value )>
		<cfif NOT arguments.autoFix>
			<cfset arguments.message = arguments.containsError>
		</cfif>
		<cfif arguments.mutable AND structKeyExists( arguments, "containsReplace" )>
			<cfset arguments.value = reReplaceNoCase( arguments.value, arguments.contains, arguments.containsReplace, "all" )>
		</cfif>
	</cfif>
</cfif>
