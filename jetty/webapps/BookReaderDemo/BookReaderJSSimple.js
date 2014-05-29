// 
// This file shows the minimum you need to provide to BookReader to display a book
//
// Copyright(c)2008-2009 Internet Archive. Software license AGPL version 3.

getLeafs=function() {
 var myTextField = document.getElementById('numLeafs');
	return myTextField.value; 
} 
getBookNumber=function() {
 var myTextField = document.getElementById('adlnumber');
	return myTextField.value; 
} 
// Create the BookReader object
br = new BookReader() 
br.numLeafs=getLeafs();
br.pageProgression = 'rl';
//Total number of Leafs
// Return the width of a given page.  Here we assume all images are 800 pixels wide
br.getPageWidth = function(index) {
    return 900;
}

// Return the height of a given page.  Here we assume all images are 1200 pixels high
br.getPageHeight = function(index) {
    //this.pageProgression = 'rl';
    return 1300;
}

// We load the images from archive.org -- you can modify this function to retrieve images
// using a different URL structure
br.getPageURI = function(index, reduce, rotate) {
    // reduce and rotate are ignored in this simple implementation, but we
    // could e.g. look at reduce and load images from a different directory
    // or pass the information to an image server
    var leafStr = '000';            
    var imgStr = (index+1).toString();
    var re = new RegExp("0{"+imgStr.length+"}$");
    //var url = 'http://localhost:8983/BookReaderDemo/images/adl0196_'+leafStr.replace(re, imgStr) + 's.jpg';
    var url = 'http://hdl.handle.net/2333.1/'+getBookNumber()+'/'+leafStr.replace(re, imgStr);
    return url;
}

// Return which side, left or right, that a given page should be displayed on
br.getPageSide = function(index) {
    if (0 == (index & 0x1)) {
        return 'L';
    } else {
        return 'R';
    }
}
// This function returns the left and right indices for the user-visible
// spread that contains the given index.  The return values may be
// null if there is no facing page or the index is invalid.
br.getSpreadIndices = function(pindex) {
    //this.pageProgression = 'rl';
    var spreadIndices = [null, null];
    if ('rl' == this.pageProgression) {
        // Right to Left
        if (this.getPageSide(pindex) == 'R') {
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex + 1;
        } else {
            // Given index was LHS
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex - 1;
        }
    } else {
        // Left to right
        if (this.getPageSide(pindex) == 'L') {
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex + 1;
        } else {
            // Given index was RHS
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex - 1;
        }
    }
   
    return spreadIndices;
}

// For a given "accessible page index" return the page number in the book.
//
// For example, index 5 might correspond to "Page 1" if there is front matter such
// as a title page and table of contents.
br.getPageNum = function(index) {
    return index+1;
}

// Total number of leafs

// Book title and the URL used for the book title link
br.bookTitle= 'ADL Bookreader Presentation';
br.bookUrl  = 'http://afghanistandl.nyu.edu';

// Override the path used to find UI images
br.imagesBaseURL = '../BookReader/images/';

br.getEmbedCode = function(frameWidth, frameHeight, viewParams) {
    return "Embed code not supported in bookreader demo.";
}

// Let's go!
br.init();

// read-aloud and search need backend compenents and are not supported in the demo
$('#BRtoolbar').find('.read').hide();
$('#textSrch').hide();
$('#btnSrch').hide();
