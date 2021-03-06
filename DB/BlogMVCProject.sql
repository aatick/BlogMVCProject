USE [master]
GO
/****** Object:  Database [BlogProjectDB]    Script Date: 2/20/2015 10:00:46 AM ******/
CREATE DATABASE [BlogProjectDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlogProjectDB', FILENAME = N'd:\Installed Softwares\Microsoft SQL Server 2012\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogProjectDB.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BlogProjectDB_log', FILENAME = N'd:\Installed Softwares\Microsoft SQL Server 2012\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogProjectDB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BlogProjectDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlogProjectDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlogProjectDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlogProjectDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlogProjectDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlogProjectDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlogProjectDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlogProjectDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BlogProjectDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BlogProjectDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlogProjectDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlogProjectDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlogProjectDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlogProjectDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlogProjectDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlogProjectDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlogProjectDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlogProjectDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BlogProjectDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlogProjectDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlogProjectDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlogProjectDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlogProjectDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlogProjectDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [BlogProjectDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlogProjectDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BlogProjectDB] SET  MULTI_USER 
GO
ALTER DATABASE [BlogProjectDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlogProjectDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlogProjectDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlogProjectDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BlogProjectDB]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/20/2015 10:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 2/20/2015 10:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CommentDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 2/20/2015 10:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](300) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[PostedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[NoOfView] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Posts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/20/2015 10:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[UserName] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](30) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201502181515287_version1', N'BlogMVCProject.Migrations.Configuration', 0x1F8B0800000000000400ED5BD96EE336147D2FD07F10F4D41619CB4950A00DEC19649CA40866B220CE047D1BD012EDB0A54855A432368A7E591FFA49FD8592DA45525BBC25C5202F0AC9BBF2F2F09297FEF7EF7F46EF963EB69E60C8102563FB7030B42D485CEA21B218DB119FBFF9C97EF7F6DB6F46E79EBFB41EB271C7729CA0246C6C3F721E9C380E731FA10FD8C0476E48199DF3814B7D0778D4391A0E7F760E0F1D2858D88297658DEE22C2910FE37FC4BF134A5C18F008E02BEA41CCD276D1338DB95AD7C0872C002E1CDBEF315D5C3D4C6E43FA1B74F92021B0AD538C8050660AF1DCB6002194032E543DF9C4E09487942CA6816800F87E1540316E0E3083A90927C5F0AED60C8FA4354E4198B17223C6A9DF93E1E171EA1E47257F9693EDDC7DC281E7C2D17C25AD8E9D38B627D4F721E1B6A5CA3A99E0508EAB71F120253CB0AADD07795488E0917F07D624C23C0AE198C08887001F58B7D10C23F7035CDDD3DF21199308E3B292424DD15769104D827F0043BEBA83F354F54BCFB69C2A9DA312E664259AC4AA4BC28F8F6CEB5A0807330CF318287960CA69087F8104868043EF16700E432279C0D88B9A74459608631EBB361128E24EAC22DBBA02CB8F902CF8E3D8169FB6758196D0CB5A52253E1124169D20E261040D4AB6098EA7E64C689D0997DFF76289F5E6754B196F775A330FB1E8C275795CB23388A198868CCD7B4A3104A49DD13578428B78420DA6D9D61DC471277B4441021803D9F13975A2C0928B90FA7714A71479C7E77B102EA09C5E6AEA9DD228747B68239D64D4467618B5A97468DA547B4DDA8C9C020D1A312271545F8090545FD1A156D63DE2183660C3F170B81D6CD81328C97080DE463069337812C7197B7C06A26C0C9A1446D7F466FE80E0979E96D5424A011ACF07B90C38CC209781CE66404EF2D6112E6E35C35BD2B516B6251AF5C53649F515DB6A655D08D6F2AB01650E7FDC0ABCC98969917CBC15C1E73E4078F7F6DE02C6BED0D0DBB9BD93108267E3F9F310AB6322A42296394DEA932436A8D304594645AA68D605B24E19A32E8AA597742A1C5135E49C7856238E276192ED0022520446A140A092102DC2D456D1E78624BB9B75EA2627D809602EF0F44915EA7BDD74C9B1BCD0253F8656D5F941932240108612850016A90C13B08A08D711131117050037B94221EA08B4D2D09CBDDA7306034824463699DD456E76EAD265E72214E7B7F965E494E2A839BCAAEBAC6E4A6B165D31A5C9CEBA93F0AA3909ED2ABC8CAED8417819CDEE22374BA0F7175E096E36CEA702A2FB0B2C25016D06D04D8654C503BB8AA78AB52F2C98920D521E6105050C5305641A7E368B0FB64BD33D8550304DE7599AECA8D32DB94E21D7929062435671C4696691A6051A7D12312DC4D2A126E224EE15E292A7AAE24B9952698CF1F0A74E5C5B0E912B9C1BAACD7DDBD65F6251E8A92ECCAA6D1DEC563244DDEE86ADADC3E656523A9DA306BBCD7BD216ED4EA7A2C66803E0B6416E7F73AB48D916260D8666B970BED48B129093D480B25A9153532C1A5D81201047A152F1286DB1A649E568F266DABF9EE2273C1C9719CA2AB9B6B924718C060BA8F4CAA9F7E0050A99BCA20733204F4813CFD7865581AD063432590A76E93395A1494620BF0B00AD2DF018F68094C385B04D8E88CD847A64EB9471050F60101AEE262614473EA9DFC7EAA9F32BCD328BBCB10F9F52D9A4CAABD4D19D5F96C49759D525F6F55CB2EDB5CCA56ECB6DF0707147597174D1ACF31A39CA446B1BBC16545A66550DD24E215C87547DE337DE6BFB07AF996C3B919BD600CA0CD2A6DD477FF97E5E8DD8AC7DF7515BBAA4AFC66DA963BBABA08E5771595F6655B4BE98F594ECDDEBAFA738FDECBF9ECC64DB594FC5BD739947D1DA2F7E754E456B774EE9C570994DDAD4636DE6B7BC959599B7F6408BF2B56D0531CA1D3B8E5D2DDB5387E4D2F3AC4FC9EE4669A6D5FE5E484BBD9221B6251CF5843C99764D5702F1FC811C3098FE812718C5509A0DB80204CD21E34909C73E1A1E1E29EF8D5ECEDB1F87310F777B00B4F33214924E6D2D34AD57DE264F20741F41F89D0F96DF6FE21D8D27BEF9FAEF6890F1C5D525F1E0726CFF19939C5897BF7E4EA80EAC9B5004DE8935B4FE5AB358DE557042B59660AD2C3E43BC8549BF1729FF8F88ADBC03C9E2557F09B2CF75A03FDD78F632D863346AEF3DDAE3712341AD3351DF79C46ED8CCC2D0B3AD57BB30D44704C6B51197D5D77C2350B3E8D67B02B0316DD50AFFA6B43514F03BAEEA6D14AAF75598CE2FF4775A8BDE4531A7FEFAEED5969BF75505DC7D90D49CB5F71A24AFA168BCAF08E90461AF2C363A03D5DE0BC07A39A5E6624CFDCD4B7D7D37B915105BE28C8A794DB6C2DA829DA9FA5B5BFC35713697C74C75E1DAB2B089ADB16AB7838AB156FA6BAC1C2AB351A920BDB092B05613DDB761EBD77CFB99D469763753D7D56FF4046E947E2728F08AA145C142FE6A9040B78218F9984B32A71970291A654394F4F80A7220F261701A7234072E17DD2E642C7E5CFB007014E7FB33E85D929B8807111726437F862B4FA3250036C98F8BD7559D473741FCCC7413260835914CE96FC8FB08612FD7FBC290D2D7B090C89A1EE9E45C7279B45BAC724ED794746494BA2FDF10EEA11F60C18CDD90297882CFD14D04EB47B800EE2ABB98AD67D23E1155B78FCE105884C067298F825EFC2B62D8F3976FFF039AFBE3D72E3B0000, N'6.1.2-31219')
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (17, N'Very Good Blog.', CAST(0x0000A4410164B530 AS DateTime), 14, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (18, N'Thank You Very Much', CAST(0x0000A43C00C8E164 AS DateTime), 15, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (19, N'I didn''t understand', CAST(0x0000A43700AE6294 AS DateTime), 14, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (20, N'You should do your best.', CAST(0x0000A442000DA0AC AS DateTime), 15, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (21, N'I am new to this blog', CAST(0x0000A442000E4138 AS DateTime), 16, 8, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (22, N'go to dhaka', CAST(0x0000A442000ED864 AS DateTime), 14, 8, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (23, N'It is very easy to learn c#', CAST(0x0000A44200D96C8C AS DateTime), 15, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (24, N'I am feeling good', CAST(0x0000A44200D9B084 AS DateTime), 16, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (25, N'I am new in this blog', CAST(0x0000A442010A8038 AS DateTime), 14, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (26, N'I am new in this blog.', CAST(0x0000A44201270884 AS DateTime), 16, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (27, N'I want to learn SQL.', CAST(0x0000A4430018DDA0 AS DateTime), 15, 4, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (28, N'Good night bro.', CAST(0x0000A443001CDB80 AS DateTime), 14, 4, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (29, N'i am very happy to visit this blog.', CAST(0x0000A443001D1294 AS DateTime), 16, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (30, N'its good.', CAST(0x0000A44301233BDC AS DateTime), 16, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (31, N'very good.', CAST(0x0000A4430123D68C AS DateTime), 15, 7, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (32, N'hi i am fine.', CAST(0x0000A444003E7089 AS DateTime), 16, 3, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (33, N'Valo hoi nai....', CAST(0x0000A44400C38748 AS DateTime), 18, 15, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (34, N'lol.', CAST(0x0000A44400C49980 AS DateTime), 18, 7, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (35, N'ok. lul.', CAST(0x0000A44400C4A463 AS DateTime), 18, 7, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (36, N'It''s very nice to read your post.', CAST(0x0000A44500709867 AS DateTime), 35, 7, 0)
INSERT [dbo].[Comments] ([Id], [Content], [CommentDate], [PostId], [UserId], [IsDeleted]) VALUES (37, N'share your intelligent comments.', CAST(0x0000A445008EC835 AS DateTime), 38, 17, 0)
SET IDENTITY_INSERT [dbo].[Comments] OFF
SET IDENTITY_INSERT [dbo].[Posts] ON 

INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (13, N'Basic ASP.NET Learning', N'If You want to learn asp.net and c#.net you first have to know the basic of OOP i.e. Object Oriented Programming. So you should start with c#.', CAST(0x0000A44001027D70 AS DateTime), 9, 1, 0, 88)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (14, N'Basic SQL Learning', N'If You want to learn Microsoft SQL Server you first have to know the basic syntax of SQL. So you should start with W3Schools.', CAST(0x0000A44001027D70 AS DateTime), 3, 1, 0, 89)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (15, N'E-learning', N'If You want to learn Microsoft SQL Server you first have to know the basic syntax of SQL. So you should start with W3Schools.', CAST(0x0000A43C00D0D874 AS DateTime), 4, 1, 0, 55)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (16, N'How to find and attract the best developers globally', N'Fingers deep in a keyboard, large headphones on, and a can of energy drink within reach flashes the paradigm of the traditional developer. Perhaps our figment of artificial intelligence is in the middle of a hackathon, maxing out mad coding skills in the programming languages that speak in new volumes to better UX, capabilities and functionality never seen by the likes of everyday Web users before.', CAST(0x0000A44100BAE7A8 AS DateTime), 3, 1, 1, 63)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (17, N'The 10 Best Free Blog Sites', N'Considering we live in an age where bloggers are sitting front row at Fashion Week, it’s not shocking that more and more women wondering how to start a blog of their own. course, how to become successful and how to actually make money blogging is its own beast—it’s easy to write about shoes and skirts, but when it comes to the technical stuff it takes serious smarts—but you have to start somewhere. That said, we’ve rounded up the 10 best free blog sites that’ll help you on your path. ', CAST(0x0000A41C01647390 AS DateTime), 3, 1, 0, 96)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (18, N'Top 15 Most Popular Blogs | February 2015', N'Here are the top 15 Most Popular Blogs as derived from our eBizMBA Rank which is a continually updated average of each website''s Alexa Global Traffic Rank, and U.S. Traffic Rank from both Compete and Quantcast."*#*" Denotes an estimate for sites with limited data.', CAST(0x0000A444005005A5 AS DateTime), 7, 1, 0, 111)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (35, N'Cooking', N'<p>
	<span style="font-size:16px;">it is very easy to cook <strong><u>rice</u></strong>.</span></p>
<p>
	<span style="font-size:16px;"><span style="color: rgb(255, 0, 0);">lol. </span><span style="color:#0000ff;">smile:)</span></span></p>
', CAST(0x0000A44400C11DAD AS DateTime), 15, 1, 0, 2)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (36, N'Asp.Net', N'<p>
	Its a....</p>
', CAST(0x0000A44400C2C281 AS DateTime), 15, 1, 0, 2)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (37, N'About Bangladesh Cricket.', N'<p>
	Bangladesh have won the first match against afganistan in world cup 2015.</p>
<p>
	well done Bangladeshi Tigers.</p>
<p>
	Bravo.</p>
<div id="__if72ru4sdfsdfrkjahiuyi_once" style="display:none;">
	 </div>
<div id="__if72ru4sdfsdfruh7fewui_once" style="display:none;">
	 </div>
<div id="__hggasdgjhsagd_once" style="display:none;">
	 </div>
', CAST(0x0000A4450071A920 AS DateTime), 7, 1, 1, 1)
INSERT [dbo].[Posts] ([Id], [Title], [Content], [PostedDate], [UserId], [IsPublished], [IsDeleted], [NoOfView]) VALUES (38, N'Custom domains for your blog made easy', N'<div id="__if72ru4sdfsdfrkjahiuyi_once" style="display: none; text-align: justify;">
	 </div>
<p style="text-align: justify;">
	You invest a lot of time in your blog, making sure it fits your personal brand and style. And a big part of making it your own comes from what you call it and where it lives. Blogger has long let you host your blog on a custom domain, so that you can give it any URL you choose. To make that process even easier, starting today, we’re integrating Blogger directly with <a href="https://domains.google.com/about/">Google Domains</a>, allowing you to purchase a custom domain for your blog right from Blogger with just a few clicks.<br />
	<br />
	If your blog is itching for a new home, you can grab one via Google Domains by popping open Blogger and heading to the Publishing section of your blog’s Settings tab.</p>
<div id="__if72ru4sdfsdfruh7fewui_once" style="display: none; text-align: justify;">
	 </div>
<div id="__hggasdgjhsagd_once" style="display:none;">
	 </div>
', CAST(0x0000A445008E751F AS DateTime), 17, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Posts] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (3, N'Md. Muntasir Mamun', N'mamun', N'm@mail.com', N'123456', CAST(0x0000A44000045498 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (4, N'Md. Rashedul Hassan', N'rashed', N'r@mail.com', N'111111', CAST(0x0000A44000045498 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (5, N'Md. Rezaul Karim', N'reza', N're@mail.com', N'11111111', CAST(0x0000A44000C5C808 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (6, N'Md. Mahadi Hasan', N'mahadi', N'ma@mail.com', N'12345678', CAST(0x0000A44000D44888 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (7, N'Md. Atikur Rahman', N'aatick', N'aatick.ru3@gmail.com', N'00000000', CAST(0x0000A441001DD51C AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (8, N'Md. Tayabur Rahman', N'tayabur', N'tayabur@yahoo.com', N'44444444', CAST(0x0000A441001F8A38 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (9, N'Md. Abdul Jabbar', N'jabbar', N'jabbar@hotmail.com', N'88888888', CAST(0x0000A44100200094 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (10, N'Mrs. Khaleda Akter', N'khaleda', N'khaleda@gmail.com', N'77777777', CAST(0x0000A4410020D708 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (11, N'Mrs. Jannatul Ferdous', N'jannat', N'jannat@yahoo.com', N'09876543', CAST(0x0000A44100219864 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (12, N'Mrs. Khadija', N'khadiza', N'khaleda@mail.com', N'00000000', CAST(0x0000A44100242E80 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (13, N'Md. Muntasir Mamun', N'mamun', N'm@mail.com', N'123456', CAST(0x0000A4410116C85C AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (14, N'Md. Rashedul Hassan', N'rashed', N'r@mail.com', N'111111', CAST(0x0000A4410116C85C AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (15, N'Ummay Afroza', N'afroza', N'a@mail.com', N'12345678', CAST(0x0000A44400BE0170 AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (16, N'Mrs. Shahana Akter', N'shahana', N's@mail.com', N'01723882421', CAST(0x0000A4450072F2DB AS DateTime))
INSERT [dbo].[Users] ([Id], [FullName], [UserName], [Email], [Password], [CreatedDate]) VALUES (17, N'Shamima Nasrin', N'Bithi', N'sh@mail.com', N'12345', CAST(0x0000A445008D8F53 AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Index [IX_PostId]    Script Date: 2/20/2015 10:00:46 AM ******/
CREATE NONCLUSTERED INDEX [IX_PostId] ON [dbo].[Comments]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 2/20/2015 10:00:46 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[Comments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 2/20/2015 10:00:46 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[Posts]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Comments_dbo.Posts_PostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_dbo.Comments_dbo.Posts_PostId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Comments_dbo.Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_dbo.Comments_dbo.Users_UserId]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Posts_dbo.Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_dbo.Posts_dbo.Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [BlogProjectDB] SET  READ_WRITE 
GO
