//
//  ViewController.m
//  冒泡
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSMutableArray * array = [self bubblingArray:[NSMutableArray arrayWithObjects:@40,@55,@23, nil]];
    NSLog(@"%@",array);
    
   
    
    
    
    Person * per1 = [[Person alloc]initWithAge:arc4random()%100 andName:@"sad"];
    Person * per2 = [[Person alloc]initWithAge:arc4random()%100 andName:@"ajskdh"];
    Person * per3 = [[Person alloc]initWithAge:arc4random()%100 andName:@"shjbad"];
    Person * per4 = [[Person alloc]initWithAge:arc4random()%100 andName:@"yrbsbc"];
    Person * per5 = [[Person alloc]initWithAge:arc4random()%100 andName:@"bvhjsb"];
    Person * per6 = [[Person alloc]initWithAge:arc4random()%100 andName:@"kjsadkj"];
    NSArray * arr = @[per1,per2,per3,per4,per5,per6];
    NSLog(@"%@",[self paixuArray:arr WithKey:@"_age"]);







}
/**
 *  对数组中的对象按属性排序
 *
 *  @param array 对象数组
 *  @param key   按某个属性排序  key属性
 *
 *  @return 排序后的数组
 */
-(NSArray *)paixuArray:(NSArray *)array  WithKey:(NSString *)key
{
    NSSortDescriptor *sortAgeDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
    NSArray *sortDesArray = @[sortAgeDescriptor];
    NSArray *SortArray = [array sortedArrayUsingDescriptors:sortDesArray];
    
    return SortArray;
}
/**
 *  优先级排序
 *
 *  @param array 对象数组
 *  @param keys  按某个属性排序   排序按照sortDesArray中的先后顺序为优先级，进行排序
 *
 *  @return 排序后的数组
 */
-(NSArray *)paixuArray:(NSArray *)array  WithKeys:(NSArray *)keys
{

    //        创建sortDescriptor对象，根据_age进行排序YES，代表升序，NO，降序
    NSSortDescriptor *sortAgeDescriptor = [NSSortDescriptor sortDescriptorWithKey:keys[0] ascending:YES];
    NSSortDescriptor *sortNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:keys[1] ascending:YES];
    //        将sortDescriptor对象添加到数组中
    NSArray *sortDesArray = @[sortAgeDescriptor,sortNameDescriptor];
    //        排序
    //        优先级以_age优先，如果年龄相同，再根据_name排序
    NSArray *ageSortArray = [array sortedArrayUsingDescriptors:sortDesArray];
    NSLog(@"排序后:%@",ageSortArray);

    return ageSortArray;
}



//冒泡OC
-(NSMutableArray *)bubblingArray:(NSMutableArray *)array{
    //  正向排序
    for (NSInteger i = 0; i<array.count; i++) {
        for (NSInteger j = i; j<array.count; j++) {
            if (array[i] > array[j]) {
                id temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
        }
    }
    return array;
}

#if 0


//冒泡C
void swap(int *a, int *b); //交换两个数
void swap(int *a, int *b)
{
    int     c;
    c = *a;
    *a = *b;
    *b =  c;
}

int main()
{
    int     str[10];
    int     i, j;
    //初始化数组为10 9 8 7 6 5 4 3 2 1
    for (i = 0; i < 10; i++)
    {
        str[i] = 10 - i;
    }
    //排序，从a[0]开始排，从小到大
    for (i = 0; i < 10; i++)
    {
        for (j = i + 1; j < 10; j++)
        {
            if (str[i] > str[j])
            {
                swap(&str[i], &str[j]);
            }
        }
    }
    //将十个数输出
    for (i = 0; i < 10; i++)
        printf("%d\n", str[i]);
    return    0;
}


#endif
























@end
