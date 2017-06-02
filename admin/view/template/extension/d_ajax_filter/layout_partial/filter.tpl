<div id="filter" class="tab-pane">
    <table class="table table-filter-default">
        <thead>
            <tr>
                <td></td>
                <td class="text-center"><?php echo $column_status; ?></td>
                <td class="text-center"><?php echo $column_type; ?></td>
                <td class="text-center"><?php echo $column_collapse; ?></td>
                <td class="text-center"><?php echo $column_sort_order_values; ?></td>
            </tr>
        </thead>
        <tbody id="fitlers">
            <tr>
                <td style="max-width: 175px;"><?php echo $text_filter_default; ?></td>
                <td class="text-center <?php echo in_array($filter_default['status'], array('default', '0'))?'disabled-next':''; ?>">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-success btn-sm <?php echo ($filter_default['status'] == 'default')?'active':''; ?>">
                            <input type="radio" name="module_setting[filter_default][status]" value="default" <?php echo ($filter_default['status'] == 'default')?'checked="checked"':''; ?> />
                            <?php echo $text_default; ?>
                        </label>
                        <label class="btn btn-success btn-sm <?php echo ($filter_default['status'] == '1')?'active':''; ?>">
                            <input type="radio" name="module_setting[filter_default][status]" value="1"<?php echo ($filter_default['status'] == '1')?'checked="checked"':''; ?> />
                            <?php echo $text_yes; ?>
                        </label>
                        <label class="btn btn-success btn-sm <?php echo ($filter_default['status'] == '0')?'active':''; ?>">
                            <input type="radio" name="module_setting[filter_default][status]" value="0" <?php echo ($filter_default['status'] == '0')?'checked="checked"':''; ?> />
                            <?php echo $text_no; ?>
                        </label>
                    </div>
                </td>
                <td class="text-center">
                    <select class="form-control" name="module_setting[filter_default][type]">
                        <?php foreach ($base_types as $base_type_key => $base_type_title) { ?>
                        <?php if(in_array($base_type_key, $default['allowed_types'])) {?>
                        <?php if($base_type_key == $filter_default['type']) { ?>
                        <option value="<?php echo $base_type_key; ?>" selected="selected"><?php echo $base_type_title; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $base_type_key; ?>"><?php echo $base_type_title; ?></option>
                        <?php } ?>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </td>
                <td class="text-center">
                    <input type="hidden" name="module_setting[filter_default][collapse]" value="0" />
                    <input type="checkbox" class="form-control switcher" data-label-text="<?php echo $text_enabled; ?>" value="1"  name="module_setting[filter_default][collapse]" <?php  echo ($filter_default['collapse'])? "checked='checked'":'';?>/>
                </td>
                <td class="text-center">
                    <select class="form-control" name="module_setting[filter_default][sort_order_values]">
                        <?php foreach ($sort_order_types as $sort_order_type_key => $sort_order_type_title) { ?>
                        <?php if($sort_order_type_key == $filter_default['sort_order_values']) { ?>
                        <option value="<?php echo $sort_order_type_key; ?>" selected="selected"><?php echo $sort_order_type_title; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $sort_order_type_key; ?>"><?php echo $sort_order_type_title; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="h2 header-title"><?php echo $text_individual_filter_setting; ?></div>
    <div class="row">
        <div class="col-md-6">
            <p><?php echo $text_warning_select_filter; ?></p>
            <div class="input-group">
                <input type="text" class="form-control" name="select_filter_name"/>
                <input type="hidden" name="select_filter_group_id"/>
                <span class="input-group-btn">
                    <a id="add-filter" class="btn btn-default"><i class="fa fa-plus"></i></a>
                </span>
            </div>
        </div>
        <div class="col-md-6">
            <div class="bs-callout bs-callout-info">
                <h4><?php echo $text_important; ?></h4>
                <?php echo $text_warning_filter_individual; ?>
            </div>
        </div>
    </div>
    <table class="table table-filter-select">
        <thead>
            <tr>
                <td></td>
                <td class="text-center"><?php echo $column_status; ?></td>
                <td class="text-center"><?php echo $column_type; ?></td>
                <td class="text-center"><?php echo $column_collapse; ?></td>
                <td class="text-center"><?php echo $column_sort_order_values; ?></td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            <?php if(!empty($filters)) { ?>
            <?php foreach ($filters as $filter_group_id => $filter) { ?>
            <tr id="element-filters-<?php echo $filter_group_id; ?>" data-sort-order="<?php echo $filter['sort_order'] ?>">
                <td style="max-width: 175px;"><?php echo $filter['name']; ?></td>
                <td class="text-center <?php echo in_array($filter['status'], array('default', '0'))?'disabled-next':''; ?>">
                    <input type="hidden" name="module_setting[filters][<?php echo $filter_group_id; ?>][sort_order]"  class="sort-value" value="<?php echo $filter['sort_order'] ?>"/>
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-success btn-sm <?php echo ($filter['status'] == 'default')?'active':''; ?>">
                            <input type="radio" name="module_setting[filters][<?php echo $filter_group_id; ?>][status]" value="default" <?php echo ($filter['status'] == 'default')?'checked="checked"':''; ?> />
                            <?php echo $text_default; ?>
                        </label>
                        <label class="btn btn-success btn-sm <?php echo ($filter['status'] == '1')?'active':''; ?>">
                            <input type="radio" name="module_setting[filters][<?php echo $filter_group_id; ?>][status]" value="1"<?php echo ($filter['status'] == '1')?'checked="checked"':''; ?> />
                            <?php echo $text_yes; ?>
                        </label>
                        <label class="btn btn-success btn-sm <?php echo ($filter['status'] == '0')?'active':''; ?>">
                            <input type="radio" name="module_setting[filters][<?php echo $filter_group_id; ?>][status]" value="0" <?php echo ($filter['status'] == '0')?'checked="checked"':''; ?> />
                            <?php echo $text_no; ?>
                        </label>
                    </div>
                </td>
                <td class="text-center">
                    <select class="form-control" name="module_setting[filters][<?php echo $filter_group_id; ?>][type]">
                        <?php foreach ($base_types as $base_type_key => $base_type_title) { ?>
                        <?php if(in_array($base_type_key, $default['allowed_types'])) {?>
                        <?php if($base_type_key == $filter['type']) { ?>
                        <option value="<?php echo $base_type_key; ?>" selected="selected"><?php echo $base_type_title; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $base_type_key; ?>"><?php echo $base_type_title; ?></option>
                        <?php } ?>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </td>
                <td class="text-center">
                    <input type="hidden" name="module_setting[filters][<?php echo $filter_group_id; ?>][collapse]" value="0" />
                    <input type="checkbox" class="form-control switcher" data-label-text="<?php echo $text_enabled; ?>" value="1"  name="module_setting[filters][<?php echo $filter_group_id; ?>][collapse]" <?php  echo ($filter['collapse'])? "checked='checked'":'';?>/>
                </td>
                <td class="text-center">
                    <select class="form-control" name="module_setting[filters][<?php echo $filter_group_id; ?>][sort_order_values]">
                        <?php foreach ($sort_order_types as $sort_order_type_key => $sort_order_type_title) { ?>
                        <?php if($sort_order_type_key == $filter['sort_order_values']) { ?>
                        <option value="<?php echo $sort_order_type_key; ?>" selected="selected"><?php echo $sort_order_type_title; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $sort_order_type_key; ?>"><?php echo $sort_order_type_title; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </td>
                <td><a class="delete-element-button" onclick="$(this).closest('tr').remove()"><i class="fa fa-times" aria-hidden="true"></i></a></td>
            </tr>
            <?php } ?>
            <?php } ?>
        </tbody>
    </table>
    <script>
        $(document).ready(function(){
            $(document).on('click', '#add-filter', function(){
                var filter_group_id = $('input[name="select_filter_group_id"]').val();
                var filter_name = $('input[name="select_filter_name"]').val();
                d_ajax_filter.addElement(filter_group_id, filter_name, 'filters', '.table-filter-select > tbody', 'tr', <?php echo json_encode($default); ?>, <?php echo json_encode($base_types); ?>);
                d_ajax_filter.updateSortOrder('table.table-filter-select > tbody','tr');
                $(".switcher").bootstrapSwitch({
                    'onColor': 'success',
                    'onText': '<?php echo $text_yes; ?>',
                    'offText': '<?php echo $text_no; ?>',
                });
            });
            $('[name="select_filter_name"]').autocomplete({
                'source': function(request, response) {
                    $.ajax({
                        url: 'index.php?route=extension/d_ajax_filter/filter/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                        dataType: 'json',
                        success: function(json) {
                            response($.map(json, function(item) {
                                return {
                                    label: item['name'],
                                    value: item['filter_group_id']
                                }
                            }));
                        }
                    });
                },
                'select': function(item) {
                    $('input[name=\'select_filter_name\']').val(item['label']);
                    $('input[name=\'select_filter_group_id\']').val(item['value']);
                }
            });
            d_ajax_filter.createSortable('table.table-filter-select > tbody','tr');
        });
    </script>
</div>