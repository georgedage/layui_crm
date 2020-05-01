package com.iarchie.crm_v1.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.iarchie.crm_v1.common.FileUploadUtils;
import com.iarchie.crm_v1.domain.DocTest;
import com.iarchie.crm_v1.domain.DownloadDco;
import com.iarchie.crm_v1.service.IDownloadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 类描述信息 下载中心处理类
 *
 * @author georgedage
 * @ClassName DownloadDocController
 * @Description: TODO
 * @date 2018/12/30 14:23
 * @Viersion V1.0.1
 */

@Controller
@RequestMapping("/download")
public class DownloadDocController {
    @Autowired
    private ServletContext servletContext;
    private String image = "";
    String saveDir = "";
    @Autowired
    private IDownloadService downloadService;


    @RequestMapping("/uploadView")
    public String uploadView() {
        return "documentFile/uploadFile";
    }

    @RequestMapping("/downloadView")
    public String fileView(Model model, Integer pageIndex) {
        int pageSize = 5;//每页显示的记录数
        if (pageIndex == null)
            pageIndex = 1;//第一次访问页面默认页面为第一页
        PageHelper.startPage(pageIndex, pageSize);
        List<DownloadDco> downloadDcos = downloadService.selectAll();
        //得到分页的结果对象
        PageInfo<DownloadDco> info = new PageInfo<>(downloadDcos);
        //得到分页中的person条目对象
        List<DownloadDco> pageList = info.getList();
        model.addAttribute("fileList", pageList);
        model.addAttribute("page", info);
        return "documentFile/fileDoc";
    }


    @ResponseBody
    @RequestMapping("/docSave")
    public String add(@RequestBody JSONObject jsonObject, HttpSession session) {
        com.alibaba.fastjson.JSONObject json = JSON.parseObject(jsonObject.toJSONString());
        String filemsg = json.getString("filemsg");
        System.out.println("json = " + json.toString());
        DownloadDco doc = new DownloadDco();
        doc.setFilemsg(filemsg);
        doc.setFilename(image);
        doc.setFilepath(saveDir + "\\" + image);
      /*  String user_in_session = (String) session.getAttribute("user_in_session");
        System.out.println("user_in_session = " + user_in_session);*/
        //数据写死，应该从session中获取
        doc.setFileadmin("管理员");
        int insert = downloadService.insert(doc);
        if (insert > 0) {
            return "success";
        }
        return "error";
    }


    @RequestMapping("/downFile")
    public void download1(String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dir = request.getServletContext().getRealPath("/upload");
        //设置响应头:下载文件
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
        //设置建议保存名称
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
        Files.copy(Paths.get(dir, fileName), response.getOutputStream());
    }

    @ResponseBody
    @PostMapping(value = "/uploadImg")
    public Map<String, Object> ramanage(@RequestParam("file") MultipartFile file,
                                        HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        try {
            saveDir = servletContext.getRealPath("/upload");
            System.out.println("saveDir = " + saveDir);
            image = FileUploadUtils.uploadFile(file, saveDir);
            result.put("code", 0);
            result.put("image", image);
        } catch (Exception e) {
            result.put("code", 1);
            e.printStackTrace();
        }
        return result;
    }
}
