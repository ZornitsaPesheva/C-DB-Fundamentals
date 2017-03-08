namespace Photographers.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class bd : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Photographers", "BirthDate", c => c.DateTime(nullable: false));
            DropColumn("dbo.Photographers", "Birthday");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Photographers", "Birthday", c => c.DateTime(nullable: false));
            DropColumn("dbo.Photographers", "BirthDate");
        }
    }
}
