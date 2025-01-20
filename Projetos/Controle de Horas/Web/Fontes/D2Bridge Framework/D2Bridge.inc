{
 +--------------------------------------------------------------------------+
  D2Bridge Framework Content

  Author: Talis Jonatas Gomes
  Email: talisjonatas@me.com

  This source code is provided 'as-is', without any express or implied
  warranty. In no event will the author be held liable for any damages
  arising from the use of this code.

  However, it is granted that this code may be used for any purpose,
  including commercial applications, but it may not sublicensed without
  express written authorization from the author (Talis Jonatas Gomes).
  This includes creating derivative works or distributing the source
  code through any means.

  If you use this software in a product, an acknowledgment in the product
  documentation would be appreciated but is not required.

  God bless you
 +--------------------------------------------------------------------------+
}

{-----------------------------------------------------
This file is divided into two parts: Configurations and Implementation
	* Settings: In this part there are options that can be activated or deactivated,
		thus changing the behavior of the DB2Bridge code.
		You can edit the "DEFINE" of this part to achieve the desired behavior.
	* Implementation: This part SHOULD NOT BE EDITED. Doing so may result in
		undefined behavior and difficult-to-diagnose problems.
-----------------------------------------------------}

(*//////////////// SETTINGS  ////////////////////*)

// To use the Rx Library Components, uncomment this line
//{$DEFINE RXLIB_AVAILABLE}

// To use SMComponent Components, uncomment this line
//{$DEFINE SMCOMPONENTS_AVAILABLE}

// To use DevExpress Components, uncomment this line
//{$DEFINE DEVEXPRESS_AVAILABLE}

// To use JEDI (JVCL) Components, uncomment this line
//{$DEFINE JVCL_AVAILABLE}

// To use INFOPOWER Components, uncomment this line
//{$DEFINE INFOPOWER_AVAILABLE}

// To use VCL on Windows / Delphi, uncomment this line
{$DEFINE VCL}

// To use FMX (Firemonkey) Windows / Delphi uncomment this line
//{$DEFINE FMX}

(*//////////////// IMPLEMENTATION  ////////////////////*)

{$IFDEF FMX}
  {$UNDEF VCL}
  {$UNDEF RXLIB_AVAILABLE}
  {$UNDEF SMCOMPONENTS_AVAILABLE}
  {$UNDEF DEVEXPRESS_AVAILABLE}
  {$UNDEF JVCL_AVAILABLE}
  {$UNDEF INFOPOWER_AVAILABLE}
{$ELSE}
  {$DEFINE VCL}
{$ENDIF}