//
//  ListMusic.swift
//  PlayFilemp3
//
//  Created by Vu Minh Tam on 8/26/20.
//  Copyright © 2020 Vu Minh Tam. All rights reserved.
//

import Foundation



class ListMusic {
//    var arrayMp3:[mp3] = [
//                           mp3(ID: 1, Name: "080 Track080", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 2, Name: "049 Track049", audio: sentence(sentence: "he is handsome* she is boy* she is three years old*", timeAudio: "0.4*0.7*0.8*")),
//                           mp3(ID: 3, Name: "050 Track050", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 4, Name: "051 Track051", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 5, Name: "052 Track052", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 6, Name: "053 Track053", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 7, Name: "054 Track054", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*")),
//                           mp3(ID: 8, Name: "055 Track055", audio: sentence(sentence: "she is beatuful* she is gril* she is two years old*", timeAudio: "0.1*0.2*0.4*"))
//                        ]

    var arrayMp3:[mp3]  = []
    
    init() {
        arrayMp3 = getArrayMp3()
    }
    
    func getArrayMp3() -> [mp3]{
        let a = database().arrDB
        var b: [mp3] = []
        for i in 0..<a.count {
            let d = sentence(sentence: a[i].text, timeAudio: a[i].audio)
            let c = mp3(ID: i + 1, Name: a[i].name, audio: d)
            b.append(c)
        }
        return b
    }
    
    func getdataOneMusic(ID: Int) -> sentenceOfPhrase {
        var data: sentenceOfPhrase = sentenceOfPhrase(name: "", text: "", phrase: [], secondAudio: [])
        data.name = getNameMusic(ID: ID)
        for (_, value) in arrayMp3.enumerated()
        {
            if ID == value.ID {
                var strSentence = value.audio.sentence
                var strSentenceFinal: [String] = []
                var conutCharacter = 0
                for (_, value) in strSentence.enumerated() {
                    if value == "*" {
                        conutCharacter = conutCharacter + 1
                    }
                }
                for _ in 0..<conutCharacter
                {
                    let SpaceSentence = strSentence.firstIndex(of: "*") ?? strSentence.endIndex
                    let SentenceSort = strSentence[..<SpaceSentence]
                    strSentence =  strSentence.replacingOccurrences(of: "\(SentenceSort)*" , with: "")
                    strSentenceFinal.append(String(SentenceSort))
                }
            data.phrase = strSentenceFinal
                
            var strtimeAudio = value.audio.timeAudio
            var strtimeAudioFinal: [String] = []
            var conutCharacterTimeAudio = 0
            for (_, value) in strtimeAudio.enumerated() {
                if value == "*" {
                    conutCharacterTimeAudio = conutCharacterTimeAudio + 1
                }
            }
            for _ in 0..<conutCharacterTimeAudio
            {
                let SpaceTimeAudio = strtimeAudio.firstIndex(of: "*") ?? strtimeAudio.endIndex
                let timeAudioSort = strtimeAudio[..<SpaceTimeAudio]
                strtimeAudio =  strtimeAudio.replacingOccurrences(of: "\(timeAudioSort)*" , with: "")
                strtimeAudioFinal.append(String(timeAudioSort))
            }
            data.secondAudio = strtimeAudioFinal
            }
        }
        
        let string = joinString(array: data.phrase)
        data.text = string
        
        return data
    }
    
    func getAllData() -> [mp3] {
        var arrayData: [mp3] = []
        for i in 0..<arrayMp3.count {
            let mp3F = mp3(ID: arrayMp3[i].ID , Name: arrayMp3[i].Name, audio: sentence(sentence: arrayMp3[i].audio.sentence, timeAudio: arrayMp3[i].audio.timeAudio))
            arrayData.append(mp3F)
        }
        return arrayData
    }
    
    func getNameMusic(ID: Int) -> String {
        if let index = arrayMp3.first(where: { (item) -> Bool in
            item.ID == ID
        }) {
            return index.Name
        }else {
            return ""
            print("k co du lieu id")
        }
    }
    
    func joinString(array: Array<Any>) -> String {
        var string = ""
        for i in 0..<array.count {
            let str = array[i] as! String
            string = string  + str + "\n"
        }
        return string
    }
    
}


