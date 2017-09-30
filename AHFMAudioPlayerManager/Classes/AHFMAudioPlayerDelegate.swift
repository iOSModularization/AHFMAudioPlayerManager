//
//  AHFMAudioPlayerDelegate.swift
//  AHAudioPlayer
//
//  Created by Andy Tong on 9/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyJSON
import AHFMDataCenter
import SDWebImage

public class AHFMAudioPlayerDelegate: NSObject {
    public static let shared = AHFMAudioPlayerDelegate()
    
    func playerManger(_ manager: NSObject, updateForTrackId trackId: Int, duration: TimeInterval){
        AHFMEpisode.write {
            try? AHFMEpisode.update(byPrimaryKey: trackId, forProperties: ["duration": duration])
        }
    }
    func playerManger(_ manager: NSObject, updateForTrackId trackId: Int, playedProgress: TimeInterval){
        AHFMEpisodeInfo.write {
            try? AHFMEpisodeInfo.update(byPrimaryKey: trackId, forProperties: ["lastPlayedTime": playedProgress])
        }
    }
    
    /// The following five are for audio background mode
    /// Both requiring the delegate to return a dict [trackId: id, trackURL: URL]
    /// trackId is Int, trackURL is URL
    func playerMangerGetPreviousTrackInfo(_ manager: NSObject, currentTrackId: Int) -> [String: Any] {
        if let currentEp = AHFMEpisode.query(byPrimaryKey: currentTrackId) {
            let eps = AHFMEpisode.query("showId", "=", currentEp.showId).OrderBy("createdAt", isASC: true).run()
            guard eps.count > 0 else {
                return [:]
            }
            if let currentIndex = eps.index(of: currentEp) {
                if currentIndex > 0 && currentIndex < eps.count {
                    let previousEp = eps[currentIndex - 1]
                    let url = getEpisodeURL(ep: previousEp)
                    
                    return ["trackId": previousEp.id, "trackURL": url]
                }
            }
        }
        
        return [:]
    }
    func playerMangerGetNextTrackInfo(_ manager: NSObject, currentTrackId: Int) -> [String: Any]{
        if let currentEp = AHFMEpisode.query(byPrimaryKey: currentTrackId) {
            let eps = AHFMEpisode.query("showId", "=", currentEp.showId).OrderBy("createdAt", isASC: true).run()
            guard eps.count > 0 else {
                return [:]
            }
            if let currentIndex = eps.index(of: currentEp) {
                if currentIndex >= 0 && currentIndex < eps.count - 1 {
                    let nextEp = eps[currentIndex + 1]
                    let url = getEpisodeURL(ep: nextEp)
                    
                    return ["trackId": nextEp.id, "trackURL": url]
                }
            }
        }
        return [:]
    }
    func playerMangerGetTrackTitle(_ player: NSObject, trackId: Int) -> String?{
        if let ep = AHFMEpisode.query(byPrimaryKey: trackId) {
            return ep.title
        }else{
            return nil
        }
    }
    func playerMangerGetAlbumTitle(_ player: NSObject, trackId: Int) -> String?{
        if let ep = AHFMEpisode.query(byPrimaryKey: trackId), let show = AHFMShow.query(byPrimaryKey: ep.showId) {
            return show.title
        }
        return nil
    }
    func playerMangerGetAlbumCover(_ player: NSObject, trackId: Int, _ callback: @escaping (_ coverImage: UIImage?)->Void){
        if let ep = AHFMEpisode.query(byPrimaryKey: trackId), let showFullCover = ep.showFullCover {
            let url = URL(string: showFullCover)
            SDWebImageDownloader.shared().downloadImage(with: url, options: .useNSURLCache, progress: nil, completed: { (image, _, _, _) in
                callback(image)
            })
            
            
        }
        callback(nil)
    }
}

extension AHFMAudioPlayerDelegate {
    func getEpisodeURL(ep: AHFMEpisode) -> URL {
        var url: URL?
        if let epInfo = AHFMEpisodeInfo.query(byPrimaryKey: ep.id), epInfo.isDownloaded == true {
            
            if let localFilePath = epInfo.localFilePath {
                url = URL(fileURLWithPath: localFilePath)
            }
        }
        
        if url == nil {
            if let audioURL = ep.audioURL {
                url = URL(string: audioURL)
            }else{
                print("ERROR episodeId:\(ep.id) doesn't have an audioURL nor localFilePath")
                url = URL(string: "")
            }
            
        }
        return url!
    }
}
