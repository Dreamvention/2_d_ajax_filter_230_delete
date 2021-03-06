<?php
/*
*  location: admin/model
*/

class ModelExtensionDAjaxFilterlayout extends Model {
    private $codename="d_ajax_filter";
    
    public function getModules(){
        $dir = DIR_CONFIG.$this->codename;
        $files = scandir($dir);
        $result = array();
        foreach($files as $file){
            if(strlen($file) > 1 && strpos( $file, '.php')){
                $result[] = substr($file, 0, -4);
            }
        }
        return $result;
    }
    
    public function getModuleSetting($type){
        $results = array();

        $file = DIR_CONFIG.$this->codename.'/'.$type.'.php';
        
        if (file_exists($file)) {
            $_ = array();

            require($file);

            $results = array_merge($results, $_);
        }

        return $results;
    }

    public function getBaseAttribs(){
        $results = array();
        $modules = $this->getModules();

        foreach ($modules as $type) {
            $results[$type] = $this->getModuleSetting($type);
        }
        uasort($results, function($a, $b){
            if ($a['sort_order'] == $b['sort_order']) {
                return 0;
            }
            return ($a['sort_order'] < $b['sort_order']) ? -1 : 1;
        });
        return $results;
    }

    public function getTemplates(){
        $dir = DIR_APPLICATION.'view/template/extension/'.$this->codename.'/layout_partial/*.tpl';
        $files = glob($dir);
        $result = array();
        foreach($files as $file){
            $result[] = basename($file, '.tpl');
        }
        return $result;
    }

    public function getTabs($home = true){
        $dir = DIR_APPLICATION.'view/template/extension/'.$this->codename.'/layout_partial/*.tpl';
        $files = glob($dir);
        if($home){
            $result = array('home');
        }
        else{
            $result = array();
        }

        $result = array_merge($result, array('setting', 'base_attributes','configuration', 'af_design'));

        foreach($files as $file){
            $result[] = basename($file, '.tpl');
        }

        return $this->prepareTabs($result);
    }

    public function prepareTabs($tabs){
        $results = array();
        $this->load->language('extension/'.$this->codename.'/layout');
        $icons = array('home' => 'fa fa-home','setting'=> 'fa fa-cog', 'base_attributes' => 'fa fa-list', 'configuration' => 'fa fa-wrench', 'af_design' => 'fa fa-adjust');
        foreach ($tabs as $tab) {
            $module_setting = $this->getModuleSetting($tab);

            if(isset($icons[$tab])){
                $icon = $icons[$tab];
                $title = $this->language->get('text_tab_'.$tab);
            }elseif(isset($module_setting['icon'])){
                $this->load->language('extension/'.$this->codename.'/'.$tab);
                $icon = $module_setting['icon'];
                $title = $this->language->get('text_title');

            }
            else{
                $icon = 'fa fa-list';
                $title = ucfirst(strtolower($tab));
            }

            $results[] = array(
                'title' => $title,
                'icon' => $icon,
                'href' => $tab
                );
        }

        return $results;
    }

    public function getLayoutsByModules($module_id){
        $query = $this->db->query("SELECT * FROM `".DB_PREFIX."layout_module` lm LEFT JOIN `".DB_PREFIX."layout` l ON (l.layout_id = lm.layout_id)  WHERE lm.`code`='d_ajax_filter.".(int)$module_id."'");
        $layout_data = array();
        if($query->num_rows){
            foreach ($query->rows as $row) {
                $layout_data[] = array(
                    'layout_id' => $row['layout_id'],
                    'name' => $row['name'],
                    'position' => $row['position']
                    );
            }
        }
        return $layout_data;
    }

    public function clearLayoutsByModule($module_id){
        $this->db->query("DELETE FROM `".DB_PREFIX."layout_module` WHERE `code` = '".$this->codename.".".(int)$module_id."'");
    }

    public function addModuleToLayout($module_id, $layout_id, $position, $sort_order){
        $this->db->query(sprintf("INSERT INTO `".DB_PREFIX."layout_module` SET 
            layout_id = '%s', 
            code = '%s', 
            position = '%s', 
            sort_order = '%s'", (int)$layout_id, $this->codename.'.'.(int)$module_id, $position, (int)$sort_order));
    }

    public function editModuleStatus($module_id, $status){
        $this->load->model('extension/module');
        $setting = $this->model_extension_module->getModule($module_id);
        $setting['status'] = $status;
        $this->model_extension_module->editModule($module_id, $setting);
    }

    public function getPrositionByModule($module_id){
        $query = $this->db->query("SELECT `position` FROM `".DB_PREFIX."layout_module` WHERE `code`='".$this->codename.".".(int)$module_id."' GROUP BY `position`");
        if($query->num_rows > 0){
            return $query->row['position'];
        }
        else{
            return 'column_left';
        }
        
    }

    public function getSortOrderByModule($module_id){
        $query = $this->db->query("SELECT `sort_order` FROM `".DB_PREFIX."layout_module` WHERE `code`='".$this->codename.".".(int)$module_id."' GROUP BY `sort_order`");
        if($query->num_rows > 0){
            return $query->row['sort_order'];
        }
        else{
            return '0';
        }
    }

    public function getThemes(){
        $dir = DIR_CATALOG.'view/theme/default/stylesheet/'.$this->codename.'/themes/*.css';
        $folders = glob($dir);
        $result = array();
        foreach ($folders as $folder) {
            if ($folder === '.' or $folder === '..') continue;
            $filename = basename($folder);
            $theme = str_replace('.css', '', $filename);
            $result[] = $theme;
        }

        $result[] = 'custom';
        
        return $result;
    }

    public function getTheme($theme){

        $results = array();

        $file = DIR_CONFIG.'d_ajax_filter_theme/'.$theme.'.php';
        
        if (file_exists($file)) {
            $_ = array();

            require($file);

            $results = array_merge($results, $_['theme']);
        }

        return $results;
    }
}