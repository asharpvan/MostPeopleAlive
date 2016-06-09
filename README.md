# MostPeopleAlive


Sample code to create Most Populous Year


Block Based Function that creates Person objects for us.

- (void) parseJSONResponse:(void(^)(NSMutableArray* arrayWithPeople))jsonHandler

**Creating Person Manually**

    Person *person1 = [[Person alloc]init];
    [person1 setYearOfBirth:1998];
    [person1 setYearOfDeath:2001];
    [arrayOfPeople addObject:person1];

**Creating Person Using Loop**

    for (int i = 0; i < totalNumberOfPeopleReturnedByJson; i++) {
        Person *person = [[Person alloc]init];
    [person setYearOfBirth:1900 + arc4random() % (2050 - 1900)];
    [person setYearOfDeath:[person yearOfBirth] + arc4random() % (2050 - [person yearOfBirth])];
    [arrayOfPeople addObject:person];
    }

> Where **arrayOfPeople** is a mutable array that adds Person object to
> itself and return itself when completion handler is called.
> 
> Year of Birth and Year of Death are randomly created (using loop only)
> keeping lower limit and upper limit in mind!


**Code to find out the most populous year**

    //Create Mutable Dictionary for user friendly output
    __block NSMutableDictionary *dictionaryOfPopulation = [NSMutableDictionary new];

    //Create Mutable Array for computational purposes
    __block NSMutableArray *arrayOfPopulation = [NSMutableArray new];

    //Since we know the years that we need to watch should be between 1900 and 2000
    //we run a loop starting from 1900 iterating up until 2000
    for (int i = 1900; i <= 2000; i++) {
    //Initialize a variable to keep track of population
    __block int yearByYearPopulation = 0;

    //Now we iterate the array in which we have the Person details
    [arrayWithPeople enumerateObjectsUsingBlock:^(Person *personInQuestion, NSUInteger idx, BOOL * _Nonnull stop)
    {

    /*for each person is the current year that is found to be greater or equal to person yearOfBirth
    * add 1 to the variable to keeping track of population
    */
    if( i >= [personInQuestion yearOfBirth])
        yearByYearPopulation += 1;

    /*for each person is the current year that is found to be less or equal to person yearOfDeath
    * substract 1 to the variable to keeping track of population
    */
    if([personInQuestion yearOfDeath] <= i)
        yearByYearPopulation -= 1;
    }];

    // add the year along with its population into the dictionary for better human readable output
    [dictionaryOfPopulation setObject:[NSNumber numberWithInt:yearByYearPopulation] forKey:[NSString stringWithFormat:@"%d",i]];
    //add the pouplation to array keeping track of poulation.
    [arrayOfPopulation addObject:[NSNumber numberWithInt:yearByYearPopulation]];
    }

    NSLog(@"\nPopulation Dictionary : %@",dictionaryOfPopulation);
    NSLog(@"\nPopulation Array : %@",arrayOfPopulation);

    //Get the highest Number(population) in the array that keeps track of population.
    NSNumber *highestPopulation = [arrayOfPopulation valueForKeyPath:@"@max.intValue"];
    NSLog(@"highestPopulation : %@",highestPopulation);

    //Once we have highest population we find the index. Now that we know our loop starts from 1900. Adding the same to the index recieved will give us the most populous year.
    NSUInteger index = [arrayOfPopulation indexOfObject:highestPopulation];
    NSLog(@"Year of Highest Population : %ld",index + 1900);
    }];

> Above mentioned is executed within the block parseJSONResponse which
> ensures that we already have all the instances of Person Class before
> we start working on them.






