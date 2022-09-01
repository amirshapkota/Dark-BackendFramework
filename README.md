# Dark

## How to create project and run 

### Clone the repo for creating
```
git clone https://github.com/apurbadh/Dark.git <project>
```

### Go to the project directory
```
cd <project>
```

### Install all the dependencies
```
dart pub get
```
### Start writting code in src/
```
<project>/
    bin/
    lib/
    src/
        routes.dart # Create routes here
        models.dart # Create models here
        controls.dart # Create controllers here
```

#### For migration
```
dart run :migrate
```
#### For Running the server
```
dart run :server
```