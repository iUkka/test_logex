-- <Migration ID="1906af61-f536-483e-931a-1ab17bcc4abe" />
GO

PRINT N'Altering [dbo].[Users]'
GO
if not exists(select * from sys.columns as c where c.object_id = object_id('dbo.Users') and c.name in ('home_address'))
begin
	alter table [dbo].[Users] add [home_address] [varchar] (4000) null;
end
GO
PRINT N'Creating [dbo].[p_Users_Select]'
GO
create or alter procedure [dbo].[p_Users_Select]
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
