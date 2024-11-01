namespace Phil.Widgets.Data;

public class DatabaseSeeder(AppDbContext db)
{
    public void Seed()
    {
        if (!db.Widgets.Any()) {
            Widget newWidget = new() { Name = "widget-one", Category = WidgetCategory.Whizbangs};
            db.Widgets.Add(newWidget);
            db.SaveChanges();
        }
    }
}
