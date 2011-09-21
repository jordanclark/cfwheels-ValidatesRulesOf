<cfparam name="arguments.list" type="string" default="">
<cfparam name="arguments.delimiters" type="string" default=",">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<cfparam name="arguments.multiList" type="boolean" default="false">

<cfif arguments.caseSensitive>
	<cfif arguments.multiList>
		<cfloop index="loc.singleValue" list="#arguments.value#" delimiters="#arguments.delimiters#">
			<cfif listFind( arguments.list, loc.singleValue, arguments.delimiters )>
				<cfset arguments.message = "contains the value ""#loc.singleValue#"" that was rejected, these values are restricted: #arguments.list#"><cfexit>
			</cfif>
		</cfloop>
	<cfelse>
		<cfif listFind( arguments.list, arguments.value, arguments.delimiters )>
			<cfset arguments.message = "was rejected, these values are restricted: #arguments.list#">
		</cfif>
	</cfif>
	
<cfelseif arguments.caseSensitive IS false>
	<cfif arguments.multiList>
		<cfloop index="loc.singleValue" list="#arguments.value#" delimiters="#arguments.delimiters#">
			<cfif listFind( arguments.list, singleValue, arguments.delimiters )>
				<cfset arguments.message = "contains the value ""#loc.singleValue#"" that was rejected, these values are restricted: #arguments.list# (case sensitive)"><cfexit>
			</cfif>
		</cfloop>
	<cfelse>
		<cfif listFindNoCase( arguments.list, arguments.value, arguments.delimiters )>
			<cfset arguments.message = "was rejected, these values are restricted: #arguments.list# (case sensitive)">
		</cfif>
	</cfif>
</cfif>

