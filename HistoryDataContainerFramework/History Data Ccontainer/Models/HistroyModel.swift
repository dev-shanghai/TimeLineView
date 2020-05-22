///**

/**
HistoryDataContainer
Created by: Ahmed Alqubaisi on 19/05/2020

HistroyModel



Copyright (c) 2020   ___ORGANIZATIONNAME___

+-----------------------------------------------------+
|                                                     |
|                                                     |
|                                                     |
|                                                     |
+-----------------------------------------------------+

*/

import Foundation


class HistoryDataModel {
    
    private var title: String?
    private var expanded: Bool?
    private var posts: [PostDataModel]?
    private var childs: [HistoryDataModel]?
    
    init(title:String) {
        self.title = title
    }
    
    var titleValue: String? {
      set { title = newValue }
        get { return title ?? nil }
    }
    
    
    var histroyPosts: [PostDataModel]? {
      set { posts = newValue }
        get { return posts ?? nil }
    }
    
    
    var isExpanded: Bool? {
      set { expanded = newValue }
        get { return expanded ?? nil }
    }
    
    var childItems: [HistoryDataModel]? {
      set { childs = newValue }
        get { return childs ?? nil }
    }
}


class PostDataModel {
    
    private var postTitle: String?
    private var postImageUrl: String?
    
    init(title: String, image: String) {
        self.postTitle = title
        self.postImageUrl = image
        
    }
    
    var getTitle: String? {
        get { return postTitle ?? nil }
    }
    
    var getImageUrl: String? {
        get { return postImageUrl ?? nil }
    }
}
