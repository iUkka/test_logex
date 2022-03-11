-- <Migration ID="c2b9cd97-b730-4143-a123-f1fb169a2b49" />
GO

PRINT N'Creating [dbo].[Users]'
GO
CREATE TABLE [dbo].[Users]
(
[id] [int] NOT NULL,
[first_name] [nvarchar] (128) NULL,
[last_name] [nvarchar] (128) NULL,
[age] [int] NULL
)
GO
PRINT N'Creating primary key [PK__Users__3213E83F267FA2DF] on [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK__Users__3213E83F267FA2DF] PRIMARY KEY CLUSTERED ([id])
GO
