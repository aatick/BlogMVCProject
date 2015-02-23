namespace BlogMVCProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Version2 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Users", "MobileNo", c => c.String(nullable: false));
            AddColumn("dbo.Users", "Gender", c => c.String(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Users", "Gender");
            DropColumn("dbo.Users", "MobileNo");
        }
    }
}
