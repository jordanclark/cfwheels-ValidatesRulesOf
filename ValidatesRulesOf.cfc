<cfcomponent output="false" mixin="global">

<cfset $initValidatesRulesOf()>

<cffunction name="init">
	<cfset this.version = "1.1.5">
	
	<cfreturn this>
</cffunction>


<cffunction name="$initValidatesRulesOf" mixin="controller" hint="Initializes application variables used in validation.">
	<cfset var defaults = {
		required="true"
	,	mutable="true"
	,	autoFix="false"
	,	defaultOnError="true"
	,	prefixLabel="true"
	,	sentence="true"
	,	message="is a required field that was skipped"
	}>
	
	<cfif structKeyExists( application.wheels.functions, "ValidatesRulesOf" )>
		<cfset structAppend( application.wheels.functions.ValidatesRulesOf, defaults, false )>
	<cfelse>
		<cfset application.wheels.functions.ValidatesRulesOf = defaults>
	</cfif>
	
	<cfset application.wheels.multipleValidationErrors = false>
	
	<cfset application.wheels.cacheValidatesRulesOfTemplates = {}>
</cffunction>


<cffunction name="validatesRulesOf" mixin="model" returntype="void" access="public" output="false">
	<cfargument name="properties" type="string" required="false" default="" hint="See documentation for @validatesConfirmationOf.">
	<cfargument name="rules" type="string" required="false" hint="List of rules to validate each property against.">
	<cfargument name="required" type="boolean" required="false">
	<cfargument name="mutable" type="boolean" required="false">
	<cfargument name="autoFix" type="boolean" required="false">
	<cfargument name="default" type="any" required="false">
	<cfargument name="defaultOnError" type="boolean" required="false">
	<cfargument name="prefixLabel" type="boolean" required="false">
	<cfargument name="sentence" type="boolean" required="false">
	<cfargument name="message" type="string" required="false">
	<cfargument name="when" type="string" required="false" default="onSave" hint="See documentation for @validatesConfirmationOf.">
	<cfargument name="condition" type="string" required="false" default="" hint="See documentation for @validatesConfirmationOf.">
	<cfargument name="unless" type="string" required="false" default="" hint="See documentation for @validatesConfirmationOf.">
	<cfscript>
		if( structKeyExists( arguments, "if" ) ) {
			arguments.condition = arguments[ "if" ];
			structDelete( arguments, "if" );
		}
		$args(name="validatesRulesOf", args=arguments);
		$registerValidation(methods="$validatesRulesOf", argumentCollection=arguments);
	</cfscript>
</cffunction>


<cffunction name="$validatesRulesOf" mixin="model" returnType="void" access="public" output="false">
	<cfargument name="rules" type="string" required="true">
	<cfargument name="required" type="boolean" required="false">
	<cfargument name="mutable" type="boolean" required="false">
	<cfargument name="autoFix" type="boolean" required="false">
	<cfargument name="default" type="any" required="false">
	<cfargument name="defaultOnError" type="boolean" required="false">
	<cfargument name="prefixLabel" type="boolean" required="false">
	<cfargument name="sentence" type="boolean" required="false">
	
	<cfset var loc = {}>
	
	<!--- give the variable a default if it doesn't exist or if its null --->
	<cfif NOT structKeyExists( this, arguments.property ) OR ( isSimpleValue( this[ arguments.property ]) AND NOT len( trim( this[ arguments.property ] ) ) )>
		<cfif arguments.required>
			<!--- throw an error and stop processing of further rules --->
			<!--- <cfset arguments.message = "is a required field that was skipped"> --->
			<cfset addError( property = arguments.property, message = $validationRulesErrorMessage( argumentCollection = arguments ) )>
		</cfif>
		<!--- no value so no reason to run more rules --->
		<cfset arguments.rules = "">
		<cfif arguments.mutable AND structKeyExists( arguments, "default" )>
			<cfset this[ arguments.property ] = arguments.default>
		</cfif>
	</cfif>
	
	<cfif NOT arguments.mutable>
		<cfset arguments.autoFix = false>
	</cfif>
	
	<cfset arguments.message = "">
	<cfset arguments.value = this[ arguments.property ]>
	
	<cfif arguments.mutable AND isSimpleValue( arguments.value )>
		<cfset arguments.value = trim( arguments.value )>
	</cfif>
	
	<cfloop index="loc.rule" list="#lCase( arguments.rules )#" delimiters=",">
		
		<cfset loc.template = "">
		
		<cfif application.wheels.cacheFileChecking AND structKeyExists( application.wheels.cacheValidatesRulesOfTemplates, loc.rule )>
			<cfset loc.template = application.wheels.cacheValidateRulesTemplates[ loc.rule ]>
		<cfelse>
			<cfif fileExists( expandPath( "rules/#loc.rule#.cfm" ) )>
				<cfset loc.template = "../../rules/#loc.rule#.cfm">
			<cfelseif fileExists( expandPath( "#application.wheels.pluginPath#/ValidatesRulesOf/rules/#loc.rule#.cfm" ) )>
				<cfset loc.template = "rules/#loc.rule#.cfm">
			</cfif>
			<cfif application.wheels.cacheFileChecking>
				<cfset application.wheels.cacheValidatesRulesOfTemplates[ loc.rule ] = loc.template>
			</cfif>
		</cfif>
		
		<cfif NOT len( loc.template )>
			<cfset $throw(type="Wheels.MissingTemplate", message="A template for the rule #loc.rule# could not be found as 'rules/#loc.rule#.cfm' or '../../rules/#loc.rule#.cfm'" )>
		<cfelse>
			<cfinclude template="#loc.template#">
		</cfif>
		
		<cfif len( arguments.message ) AND arguments.mutable AND arguments.defaultOnError AND structKeyExists( arguments, "default" )>
			<cfset arguments.value = arguments.default>
		</cfif>
		
		<!--- store changed value back to the property --->
		<cfif arguments.mutable>
			<cfset this[ arguments.property ] = arguments.value>
		</cfif>
		
		<cfif len( arguments.message )>
			<cfset addError( property= arguments.property, message= $validationRulesErrorMessage( argumentCollection = arguments ) )>
			<cfif NOT application.wheels.multipleValidationErrors>
				<!--- end the loop --->
				<cfbreak>
			</cfif>
		</cfif>
		
	</cfloop>
</cffunction>


<cffunction name="$validate" returntype="boolean" access="public" output="false" hint="Runs all the validation methods setup on the object and adds errors as it finds them. Returns `true` if no errors were added, `false` otherwise.">
	<cfargument name="type" type="string" required="true">
	<cfargument name="execute" type="boolean" required="false" default="true">
	<cfscript>
		var loc = {};

		// don't run any validations when we want to skip
		if (!arguments.execute)
			return true;

		// loop over the passed in types
		for (loc.typeIndex=1; loc.typeIndex <= ListLen(arguments.type); loc.typeIndex++)
		{
			loc.type = ListGetAt(arguments.type, loc.typeIndex);
			// loop through all validations for passed in type (`onSave`, `onCreate` etc) that has been set on this model object
			loc.iEnd = ArrayLen(variables.wheels.class.validations[loc.type]);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.thisValidation = variables.wheels.class.validations[loc.type][loc.i];
				// only run validations if there aren't any existing errors
				if(application.wheels.multipleValidationErrors OR !arrayLen( errorsOn(loc.thisValidation.args.property) ) )
				{
					if ($evaluateCondition(argumentCollection=loc.thisValidation.args))
					{
						if (loc.thisValidation.method == "$validatesRulesOf" OR loc.thisValidation.method == "$validatesPresenceOf")
						{
							$invoke(method=loc.thisValidation.method, invokeArgs=loc.thisValidation.args);
							/*
							// if the property does not exist or if it's blank we add an error on the object (for all other validation types we call corresponding methods below instead)
							if (!StructKeyExists(this, loc.thisValidation.args.property) or (IsSimpleValue(this[loc.thisValidation.args.property]) and !Len(Trim(this[loc.thisValidation.args.property]))) or (IsStruct(this[loc.thisValidation.args.property]) and !StructCount(this[loc.thisValidation.args.property])))
								addError(property=loc.thisValidation.args.property, message=$validationErrorMessage(loc.thisValidation.args.property, loc.thisValidation.args.message));
							*/
						}
						else
						{
							// if the validation set does not allow blank values we can set an error right away, otherwise we call a method to run the actual check
							if (StructKeyExists(loc.thisValidation.args, "property") && StructKeyExists(loc.thisValidation.args, "allowBlank") && !loc.thisValidation.args.allowBlank && (!StructKeyExists(this, loc.thisValidation.args.property) || !Len(this[loc.thisValidation.args.property])))
								addError(property=loc.thisValidation.args.property, message=$validationErrorMessage(loc.thisValidation.args.property, loc.thisValidation.args.message));
							else if (!StructKeyExists(loc.thisValidation.args, "property") || (StructKeyExists(this, loc.thisValidation.args.property) && Len(this[loc.thisValidation.args.property])))
								$invoke(method=loc.thisValidation.method, invokeArgs=loc.thisValidation.args);
						}
					}
				}
			}
		}
		// now that we have run all the validation checks we can return `true` if no errors exist on the object, `false` otherwise
		loc.returnValue = !hasErrors();
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>


<cffunction name="$validationRulesErrorMessage" mixin="model" returntype="string" access="public" output="false" hint="Creates nicer looking error text by humanizing the property name and capitalizing it when appropriate.">
	<cfargument name="property" type="string" required="true">
	<cfargument name="message" type="string" required="true">
	<cfargument name="prefixLabel" type="boolean" default="true">
	<cfargument name="sentence" type="boolean" default="true">
	
	<cfif arguments.prefixLabel>
		<cfset arguments.message = capitalize( this.$label( arguments.property ) ) & " " & arguments.message>
	</cfif>
	
	<cfif arguments.sentence AND right( arguments.message, 1 ) IS NOT ".">
		<cfset arguments.message = arguments.message & ".">
	</cfif>
	
	<cfreturn arguments.message>
</cffunction>


<cffunction name="$validatesLengthOf" returntype="void" access="public" output="false" hint="Adds an error if the object property fail to pass the validation setup in the @validatesLengthOf method.">
	<cfargument name="property" type="string" required="true">
	<cfargument name="exactly" type="numeric" required="true">
	<cfargument name="maximum" type="numeric" required="true">
	<cfargument name="minimum" type="numeric" required="true">
	<cfargument name="within" type="any" required="true">
	<cfargument name="prefixLabel" type="boolean" required="true">
	<cfargument name="properties" type="struct" required="false" default="#this.properties()#">
	<cfscript>
		var _lenValue = Len(arguments.properties[arguments.property]);
		var _errorMsg = "";
		
		// for within, just create minimum/maximum values
		if (IsArray(arguments.within) && ArrayLen(arguments.within) eq 2)
		{
			arguments.minimum = arguments.within[1];
			arguments.maximum = arguments.within[2];
		} else if( listLen(arguments.within,"-,") IS 2 ) {
			arguments.minimum = listGetAt( arguments.within, 1, "-," );
			arguments.maximum = listGetAt( arguments.within, 2, "-," );
		}
		
		if( arguments.exactly ) {
			if( _lenValue IS NOT arguments.exactly ) {
				_errorMsg = "must be exactly #arguments.exactly# characters long";
			}
		} else if( arguments.maximum AND arguments.minimum ) {
			if( _lenValue GT arguments.maximum OR _lenValue LT arguments.minimum ) {
				_errorMsg = "must be between #arguments.minimum#-#arguments.maximum# characters long";
			}
		} else if( arguments.maximum ) {
			if( _lenValue GT arguments.maximum ) {
				_errorMsg = "must be no more than #arguments.maximum# characters long";
			}
		} else if( arguments.minimum ) {
			if( _lenValue LT arguments.minimum ) {
				_errorMsg = "must be at least #arguments.minimum# characters long";
			}
		}
		
		if( len( _errorMsg ) ) {
			arguments.message = _errorMsg;
			if( arguments.prefixLabel ) {
				arguments.message = "[property] " & arguments.message;
			}
			addError(property=arguments.property, message=$validationErrorMessage(argumentCollection=arguments));
		}
		
	</cfscript>
</cffunction>


<cffunction name="$validatesUniquenessOf" returntype="void" access="public" output="false">
	<cfargument name="property" type="string" required="true">
	<cfargument name="message" type="string" required="true">
	<cfargument name="scope" type="string" required="false" default="">
	<cfargument name="properties" type="struct" required="false" default="#this.properties()#">
	<cfargument name="includeSoftDeletes" type="boolean" required="false" default="true">
	<cfscript>
		var loc = {};
		loc.where = [];

		// create the WHERE clause to be used in the query that checks if an identical value already exists
		// wrap value in single quotes unless it's numeric
		// example: "userName='Joe'"
		ArrayAppend(loc.where, "#arguments.property#=#variables.wheels.class.adapter.$quoteValue(this[arguments.property])#");

		// add scopes to the WHERE clause if passed in, this means that checks for other properties are done in the WHERE clause as well
		// example: "userName='Joe'" becomes "userName='Joe' AND account=1" if scope is "account" for example
		arguments.scope = $listClean(arguments.scope);
		if (Len(arguments.scope))
		{
			loc.iEnd = ListLen(arguments.scope);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.property = ListGetAt(arguments.scope, loc.i);
				ArrayAppend(loc.where, "#loc.property#=#variables.wheels.class.adapter.$quoteValue(this[loc.property])#");
			}
		}

		// try to fetch existing object from the database
		loc.existingObject = findOne(select=primaryKey(),where=ArrayToList(loc.where, " AND "), reload=true, includeSoftDeletes=arguments.includeSoftDeletes);

		// we add an error if an object was found in the database and the current object is either not saved yet or not the same as the one in the database
		if (IsObject(loc.existingObject) && (isNew() || loc.existingObject.key() != key($persisted=true)))
		{
			addError(property=arguments.property, message=$validationErrorMessage(argumentCollection=arguments));
		}
	</cfscript>
</cffunction>


</cfcomponent>