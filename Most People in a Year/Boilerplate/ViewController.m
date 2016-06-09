//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
       
        [self setTitle:@"Title"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self parseJSONResponse:^(NSMutableArray *arrayWithPeople) {
            
            NSLog(@"array of People Count : %ld", [arrayWithPeople count]);
            NSLog(@"Start Processing here");

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
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) parseJSONResponse:(void(^)(NSMutableArray* arrayWithPeople))jsonHandler {
  
    NSMutableArray *arrayOfPeople = [NSMutableArray new];
    
    
    
    /* Run a loop to imitate Json Response. Suppose JSON returnes N number of
     *People. We can create custom Person objects by passing n to the variable totalNumberOfPeopleReturnedByJson
     */
  
    /*To create n number of Persons. Please Uncomment the following code and assign the number n to variable
     *totalNumberOfPeopleReturnedByJson.
     */
    
    int totalNumberOfPeopleReturnedByJson = 10;
    
    for (int i = 0; i < totalNumberOfPeopleReturnedByJson; i++) {
        Person *person = [[Person alloc]init];
        [person setYearOfBirth:1900 + arc4random() % (2050 - 1900)];
        [person setYearOfDeath:[person yearOfBirth] + arc4random() % (2050 - [person yearOfBirth])];
        [arrayOfPeople addObject:person];
        NSLog(@"\n***************** Person  Details Start ******************\nYOB : %d\nYOD : %d\n****************** Person  Details End ******************",[person yearOfBirth],[person yearOfDeath]);//
    }
    
     /*To create manual Person objects. Please Uncomment the following code. You can create as many Person objects as you
      *like.
      */
/*
    Person *person1 = [[Person alloc]init];
    [person1 setYearOfBirth:1998];
    [person1 setYearOfDeath:2001];
    [arrayOfPeople addObject:person1];
    NSLog(@"\n***************** Person 1  Details Start ******************\nYOB : %d\nYOD : %d\n****************** Person 1  Details End ******************",[person1 yearOfBirth],[person1 yearOfDeath]);
   
    Person *person2 = [[Person alloc]init];
    [person2 setYearOfBirth:1997];
    [person2 setYearOfDeath:2000];
    [arrayOfPeople addObject:person2];
    NSLog(@"\n***************** Person 2  Details Start ******************\nYOB : %d\nYOD : %d\n****************** Person 2  Details End ******************",[person2 yearOfBirth],[person2 yearOfDeath]);
 */
    
    jsonHandler(arrayOfPeople);
}
@end
