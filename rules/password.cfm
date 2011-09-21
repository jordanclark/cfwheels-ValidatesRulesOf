<cfparam name="arguments.passwordType" type="string" default="standard">
<cfparam name="arguments.verifyProperty" type="string" default="">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">

<cfswitch expression="#arguments.passwordType#">

	<cfcase value="standard">
		<!--- values are the same --->
		<!--- only contain letters, numbers, underscore, hyphens --->
		<cfif reFindNoCase( "[^a-z0-9_-]", arguments.value )>
			<cfif arguments.mutable>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9 _-]", "", "all" )>
			</cfif>
			<cfset arguments.message = "can only contain letters ""A-Z"", numbers ""0-9"" and the special characters hyphen ""-"" and underscores ""_""">
		</cfif>
	</cfcase>
	
	<cfcase value="withSymbols">
		<cfif reFindNoCase( "[^a-z0-9~!@##$%^&*()_+=\[\]{}\\\|:;',./?-]", arguments.value )>
			<cfif arguments.mutable>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9~!@##$%^&*()_+-=\[\]{}\\\|:;',./?-]", "", "all" )>
			</cfif>
			<cfset arguments.message = "can only contain letters ""A-Z"", numbers ""0-9"" and the special symbols: ~!@##$%^&*()_+=[]{}|:;',./?-">
		</cfif>
	</cfcase>
	
	<cfcase value="withNumbers">
		<cfif reFindNoCase( "[^a-z0-9]", arguments.value )>
			<cfif arguments.mutable>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9]", "", "all" )>
			</cfif>
			<cfset arguments.message = "can only contain letters ""A-Z"", numbers ""0-9""">
		</cfif>
	</cfcase>

</cfswitch>

<cfif NOT len( arguments.message ) AND len( arguments.verifyProperty )>

	<cfif arguments.caseSensitive>
		<cfif NOT structKeyExists( this, arguments.verifyProperty ) OR compare( arguments.value, this[ arguments.verifyProperty ] ) IS NOT 0>
			<cfif arguments.mutable>
				<cfset arguments.value = "">
				<cfset this[ arguments.verifyProperty ] = "">
			</cfif>
			<cfset arguments.message = "fields must be exactly the same, even the case">
		</cfif>
	<cfelse>
		<cfif NOT structKeyExists( this, arguments.verifyProperty ) OR compareNoCase( arguments.value, this[ arguments.verifyProperty ] ) IS NOT 0>
			<cfif arguments.mutable>
				<cfset arguments.value = "">
				<cfset this[ arguments.verifyProperty ] = "">
			</cfif>
			<cfset arguments.message = "fields must be exactly the same">
		</cfif>
	</cfif>
	
</cfif>
