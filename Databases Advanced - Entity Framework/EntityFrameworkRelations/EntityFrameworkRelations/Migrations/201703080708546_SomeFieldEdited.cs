namespace EntityFrameworkRelations.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class SomeFieldEdited : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Homework", "SubmissionDate", c => c.DateTime(nullable: false));
            DropColumn("dbo.Homework", "SubmitionDate");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Homework", "SubmitionDate", c => c.DateTime(nullable: false));
            DropColumn("dbo.Homework", "SubmissionDate");
        }
    }
}
