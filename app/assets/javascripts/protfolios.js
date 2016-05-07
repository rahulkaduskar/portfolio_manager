$(document).ready(function() {
  uploader.initFileUpload();
  $('[data-toggle="tooltip"]').tooltip(); 
})
uploader = {
  initFileUpload: function() {
    $('#fileupload').fileupload({
      url: $(this).attr("data-url")      
    });
    var upload_container = $("#uploader");
    $('#fileupload').bind("fileuploaddone", function(e, data) {
      var file = data.files[0];
      window.location.href = data.jqXHR.responseJSON.redirect_url;
    }).bind("fileuploadsubmit", function(e, data) {
      var file = data.files[0];
      data.formData = {file_for: $('#fileupload').parent().find("#file_for").val() };
      upload_container.find("#upload-progress").show();
      upload_container.find("#upload-progress > span").html(file.name);
      
    }).bind("fileuploadprogress", function(e, data) {
      if (!data.iframeUpload) {
        var percentage = parseInt(data.loaded / data.total * 100, 10);
        var progressBar = upload_container.find(".progress-bar");
        progressBar.width(percentage + "%");
        progressBar.find("span").html(percentage + "%");
      }
    }).bind("fileuploadfail", function(e, data) {
      upload_container.find("#upload-progress").hide();
      $("div.alert-danger").html(data.jqXHR.responseJSON.error).show();      
    });
  }
}

barchart = {

  init: function(datax, data, profile_name) { 
    
    $('#chart-container').highcharts({
        chart: {
          type: 'column'
      },

      legend: {
        width: 200,
        itemWidth: 100,
        title: {
          text: 'Portfolio'
        }
     },
      title: {
          text: 'Portfolio'
      },
      xAxis: {
         title: {
              text: 'Ticket name'
          },
          categories: datax
      },
      yAxis: {
          title: {
              text: 'Profit & loss'
          }
      },
      series: [{
          data: data
      }]
    });
  }

}