//
//  LXHSearchController.m
//  LXHSearchBarTest
//
//  Created by moxuyou on 16/7/25.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHSearchController.h"
#import "LXHResultController.h"

@interface LXHSearchController ()<UISearchBarDelegate,UISearchResultsUpdating>

/**  */
@property (nonatomic , strong)NSMutableArray *dataArray;
/**  */
@property (nonatomic , strong)NSMutableArray *dataArrayM;

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation LXHSearchController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        
        NSArray *array = @[@"Aaliyah", @"Aaron", @"Abigail", @"Adam", @"Addison", @"Adrian", @"Aiden", @"Alex", @"Alexa", @"Alexander", @"Alexandra", @"Alexis", @"Allison", @"Alyssa", @"Amelia", @"Andrea", @"Andrew", @"Angel", @"Anna", @"Annabelle", @"Anthony", @"Aria", @"Ariana", @"Arianna", @"Ashley", @"Aubree", @"Aubrey", @"Audrey", @"Austin", @"Autumn", @"Ava", @"Avery", @"Ayden", @"Bailey", @"Bella", @"Benjamin", @"Bentley", @"Blake", @"Brandon", @"Brayden", @"Brianna", @"Brody", @"Brooklyn", @"Bryson", @"Caleb", @"Cameron", @"Camila", @"Carlos", @"Caroline", @"Carson", @"Carter", @"Charles", @"Charlotte", @"Chase", @"Chloe", @"Christian", @"Christopher", @"Claire", @"Colton", @"Connor", @"Cooper", @"Damian", @"Daniel", @"David", @"Dominic", @"Dylan", @"Easton", @"Eli", @"Elijah", @"Elizabeth", @"Ella", @"Ellie", @"Emily", @"Emma", @"Ethan", @"Eva", @"Evan", @"Evelyn", @"Faith", @"Gabriel", @"Gabriella", @"Gavin", @"Genesis", @"Gianna", @"Grace", @"Grayson", @"Hailey", @"Hannah", @"Harper", @"Henry", @"Hudson", @"Hunter", @"Ian", @"Isaac", @"Isabella", @"Isaiah", @"Jace", @"Jack", @"Jackson", @"Jacob", @"James", @"Jasmine", @"Jason", @"Jaxon", @"Jayden", @"Jeremiah", @"Jocelyn", @"John", @"Jonathan", @"Jordan", @"Jose", @"Joseph", @"Joshua", @"Josiah", @"Juan", @"Julia", @"Julian", @"Justin", @"Katherine", @"Kayden", @"Kayla", @"Kaylee", @"Kennedy", @"Kevin", @"Khloe", @"Kimberly", @"Kylie", @"Landon", @"Lauren", @"Layla", @"Leah", @"Levi", @"Liam", @"Lillian", @"Lily", @"Logan", @"London", @"Lucas", @"Lucy", @"Luis", @"Luke", @"Lydia", @"Mackenzie", @"Madeline", @"Madelyn", @"Madison", @"Makayla", @"Mason", @"Matthew", @"Maya", @"Melanie", @"Mia", @"Michael", @"Molly", @"Morgan", @"Naomi", @"Natalie", @"Nathan", @"Nathaniel", @"Nevaeh", @"Nicholas", @"Noah", @"Nolan", @"Oliver", @"Olivia", @"Owen", @"Parker", @"Peyton", @"Piper", @"Reagan", @"Riley", @"Robert", @"Ryan", @"Ryder", @"Samantha", @"Samuel", @"Sarah", @"Savannah", @"Scarlett", @"Sebastian", @"Serenity", @"Skylar", @"Sofia", @"Sophia", @"Sophie", @"Stella", @"Sydney", @"Taylor", @"Thomas", @"Trinity", @"Tristan", @"Tyler", @"Victoria", @"Violet", @"William", @"Wyatt", @"Xavier", @"Zachary", @"Zoe", @"Zoey"];
        _dataArray = [NSMutableArray arrayWithArray:array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索功能";
    [self configureTableView:self.tableView];
    [self addSearchBarAndSearchDisplayController];
}

- (void)addSearchBarAndSearchDisplayController {
    
    LXHResultController *resultVc = [[LXHResultController alloc] init];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultVc];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.hidesNavigationBarDuringPresentation = YES;
    searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    searchController.searchBar.placeholder = @"搜索";
    searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = searchController.searchBar;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [searchController.view addSubview:view];
    
    self.searchController = searchController;
}

- (void)configureTableView:(UITableView *)tableView {
    
    tableView.separatorInset = UIEdgeInsetsZero;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    UIView *tableFooterViewToGetRidOfBlankRows = [[UIView alloc] initWithFrame:CGRectZero];
    tableFooterViewToGetRidOfBlankRows.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = tableFooterViewToGetRidOfBlankRows;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.dataArrayM count];
    }else{
        return [self.dataArray count];
    }
}
//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];

    if (self.searchController.active) {
        [cell.textLabel setText:self.dataArrayM[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.dataArrayM!= nil) {
        [self.dataArrayM removeAllObjects];
    }
    //过滤数据
    self.dataArrayM = [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

@end
