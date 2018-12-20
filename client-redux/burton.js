'use strict';

// Parse NCX

function ParseNCX(){
  var toc = [];
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
      if (xhttp.readyState == 4) {
        parseTOC(xhttp);
      }
  };
  xhttp.open("GET", "epub/psych/toc.ncx", true);
  xhttp.send();

  function parseTOC(xml) {
    var xmlDoc = xml.responseXML;
    var navMap = Array.prototype.slice.call(xmlDoc.getElementsByTagName("navMap")[0].getElementsByTagName("navPoint"));

    for (var item of navMap) {
      var text = item.getElementsByTagName("navLabel")[0].getElementsByTagName("text")[0].innerHTML;
      var src = item.getElementsByTagName("content")[0].getAttribute("src");
      toc.push({"text": text, "src": src});
    }
    return toc);
  }
}

ParseNCX();

// var RenderTOC = React.createClass()

// Render Chapter

var RenderChapter = React.createClass({
  getInitialState: function() {
    return {
      html: '',
    };
  },

  componentDidMount: function() {
    this.serverRequest = $.get(this.props.source, function (result) {
      var chapter = result;
      this.setState({
        html: chapter
      });
    }.bind(this));
  },

  componentWillUnmount: function() {
    this.serverRequest.abort();
  },

  render: function() {
    return (
      <div dangerouslySetInnerHTML={{__html: this.state.html}} />
    );
  }
});

ReactDOM.render(
  <RenderChapter source="epub/psych/OEBPS/chapter-001-slug-1-1-psychology-as-a-science.html" />,
  document.getElementById('chapter')
);
