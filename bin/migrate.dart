import "../src/models.dart";

void main(List<String> args) {
  
  for (var model in models)
  {
    if (args.length != 0 && args[0] == "--force") 
    {
      model.migrate(force: true);
    }else {
      model.migrate();
    }
    
  }
}