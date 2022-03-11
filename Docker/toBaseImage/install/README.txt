This directory must contain files:

msodbcsql_17.3.0.1_x64.msi https://download.microsoft.com/download/C/8/7/C874A5F9-3E46-4CB8-B740-937F58524795/en-US/msodbcsql_17.3.0.1_x64.msi
MsSqlCmdLnUtils.msi https://download.microsoft.com/download/0/e/6/0e63d835-3513-45a0-9cf0-0bc75fb4269e/EN/x64/MsSqlCmdLnUtils.msi
SQL2019-SSEI-Expr.exe https://download.microsoft.com/download/7/f/8/7f8a9c43-8c8a-4f7c-9f92-83c18d96b681/SQL2019-SSEI-Expr.exe for extracting SqlLocalDB.msi
VC_redist.x64.exe https://download.visualstudio.microsoft.com/download/pr/4100b84d-1b4d-487d-9f89-1354a7138c8f/5B0CBB977F2F5253B1EBE5C9D30EDBDA35DBD68FB70DE7AF5FAAC6423DB575B5/VC_redist.x64.exe

Info:
Need build with mssql 19 binaries, because i got bug
https://support.microsoft.com/en-us/topic/kb4096875-fix-access-is-denied-error-when-you-try-to-create-a-database-in-sql-server-2017-express-localdb-d9b44eb5-3d6f-ba8c-ab71-c40726d86519

PS C:\project> $testResults = Invoke-DatabaseTests $project
Invoke-DatabaseTests, SQL Change Automation 4.4.21333.28119, Copyright © Red Gate Software Ltd 2014-2021
WARNING:  GetReferenceAssemblyPaths: Warning
WARNING:  ResolveAssemblyReference: Warning
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Microsoft.Common.targets(1605,5): There was a mismatch between the
processor architecture of the project being built "MSIL" and the processor architecture of the reference
"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\mscorlib.dll", "AMD64". This mismatch may cause runtime failures.
Please consider changing the targeted processor architecture of your project through the Configuration Manager so as to
 align the processor architectures between your project and references, or take a dependency on references with a
processor architecture that matches the targeted processor architecture of your project.
build. File:C:\project\Migrations\003_20211206-1017_iUkka.sql Line:0 Column:0
WARNING:  DbBuildTask: Warning  (0,0): This script is empty. Please provide one or more T-SQL statements prior to
build. File:C:\project\Migrations\004_20211207-0039_iUkka.sql Line:0 Column:0
WARNING:  DbBuildTask: ERROR C:\Program
Files\WindowsPowerShell\Modules\SqlChangeAutomation\4.4.21333.28119\SqlChangeAutomation.Data.Schema.Ssdt.targets(117,5)
file 'C:\Users\ContainerAdministratorsql_change_automation_165e5042-46fc-4d73-94f4-02ffe19cfc4d.mdf'.
Skipping Shadow clean; [sql_change_automation_165e5042-46fc-4d73-94f4-02ffe19cfc4d] does not exist
Skipping Shadow clean; [sql_change_automation_165e5042-46fc-4d73-94f4-02ffe19cfc4d] does not exist