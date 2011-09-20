<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<!--- <cfparam name="loc.find1" type="string"> --->
<!--- <cfparam name="loc.find2" type="string"> --->
<!--- <cfparam name="loc.find3" type="string"> --->

<cfif NOT arguments.mutable>
	<cfexit>
</cfif>

<cfloop index="loc.x" from="1" to="10">
	<cfif structKeyExists( arguments, "find#loc.x#" ) AND structKeyExists( arguments, "replace#loc.x#" )>
		<cfset loc.find = arguments[ "find#loc.x#" ]>
		<cfset loc.replace = arguments[ "replace#loc.x#" ]>
		<cfif arguments.caseSensitive>
			<cfset arguments.value = replace( arguments.value, loc.find, arguments.replace, "all" )>
		<cfelse>
			<cfset arguments.value = replaceNoCase( arguments.value, loc.find, arguments.replace, "all" )>
		</cfif>
	<cfelseif structKeyExists( arguments, "refind#loc.x#" ) AND structKeyExists( arguments, "replace#loc.x#" )>
		<cfset loc.find = arguments[ "refind#loc.x#" ]>
		<cfset loc.replace = arguments[ "replace#loc.x#" ]>
		<cfif arguments.caseSensitive>
			<cfset arguments.value = reReplace( arguments.value, loc.find, arguments.replace, "all" )>
		<cfelse>
			<cfset arguments.value = replaceNoCase( arguments.value, loc.find, arguments.replace, "all" )>
		</cfif>
	<cfelse>
		<cfbreak>
	</cfif>
</cfloop>
