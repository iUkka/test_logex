﻿/*
    This script was generated by SQL Change Automation to help provide object-level history. This script should never be edited manually.
    For more information see: https://www.red-gate.com/sca/dev/offline-schema-model
*/

IF OBJECT_ID('[dbo].[p_Users_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[p_Users_Select];

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[p_Users_Select]
as
begin
	set nocount on;

	select
		u.id,
		u.first_name,
		u.last_name,
		u.age,
		u.home_address
	from dbo.Users as u;

end
GO