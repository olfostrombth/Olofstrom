$ ->
  if $('#sortable').length > 0
    #table_width = $('#sortable').width()
    #cells = $('.table').find('tr')[0].cells.length
    #desired_width = table_width / cells + 'px'
    #$('.table td').css('width', desired_width)


    $('#sortable').sortable(
      axis: 'y'
      items: '.item'
      cursor: 'pointer'
      #containment: 'document' vill ha det egentligen för att undvika för långa scrollningar, men då går item ej att lägga underst.
      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')

        #console.log ui.item.index()
        ui.item.css({
          WebkitTransform: 'rotate(3deg)',
          '-moz-transform': 'rotate(3deg)'
        });
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        ui.item.css({
          WebkitTransform: 'rotate(0deg)',
          '-moz-transform': 'rotate(0deg)'
        });
        # highlight the row on drop to indicate an update
        ui.item.effect('highlight', {}, 1000)
      update: (e, ui) ->
        item_id = ui.item.data('item-id')
        console.log $(ui).attr('id')
        #console.log(item_id)
        #console.log gon.stepname
        position = ui.item.index() # this will not work with paginated items, as the index is zero on every page

        console.log position

        $.ajax(
          type: 'POST'
          url: '/steps/update_row_order'
          dataType: 'json'
          data: { substep: {substep_id: item_id, row_order_position: position, name: gon.stepname } }
        )
    )
