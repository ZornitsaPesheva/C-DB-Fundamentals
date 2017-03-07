namespace EntityFrameworkRelations.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddSomeRelations : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Homework", "Type", c => c.Int(nullable: false));
            AddColumn("dbo.Resources", "Type", c => c.Int(nullable: false));
            AlterColumn("dbo.Students", "Birthday", c => c.DateTime());
            DropColumn("dbo.Homework", "ContentType");
            DropColumn("dbo.Resources", "TypeOfResource");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Resources", "TypeOfResource", c => c.String(nullable: false));
            AddColumn("dbo.Homework", "ContentType", c => c.Binary(nullable: false));
            AlterColumn("dbo.Students", "Birthday", c => c.DateTime(nullable: false));
            DropColumn("dbo.Resources", "Type");
            DropColumn("dbo.Homework", "Type");
        }
    }
}
